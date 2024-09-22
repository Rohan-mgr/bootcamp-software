require "csv"

module Mutations
  module Orders
    class OrderCsvUpload < BaseMutation
      argument :file, String, required: true

      field :message, String, null: false
      field :errors, [ String ], null: false

      def resolve(file:)
        decoded_data = decode_file(file)
        csv_data = CSV.parse(decoded_data, headers: true)

        results = {
          message: "CSV processing completed",
          errors: []
        }

        csv_data.each_with_index do |row, index|
          order_info = {
            status: row["status"],
            started_at: row["started_at"],
            customer_id: row["customer_id"],
            recurring: JSON.parse(row["recurring"]).nil? ? JSON.parse(row["recurring"]) : JSON.parse(row["recurring"]).deep_symbolize_keys,
            delivery_order_attributes: JSON.parse(row["delivery_order_attributes"]).deep_symbolize_keys.merge(
              line_items_attributes: JSON.parse(row["line_items_attributes"]).map { |item| item.deep_symbolize_keys }
            )
          }

          begin
            order_service = ::Orders::OrderService.new(order_info.to_h.merge(current_user: context[:current_user])).execute_order_creation
            unless order_service.success?
              results[:errors] << "Row #{index + 1}: #{order_service.errors.join(', ')}"
            end
          rescue => e
            results[:errors] << "Row #{index + 1}: #{e.message}"
          end
        end

        if results[:errors].empty?
          results[:message] = "All orders created successfully"
        else
          results[:message] = "Some orders failed to create"
        end

        results
      rescue => e
        {
          message: "Failed to process CSV",
          errors: [ e.message ]
        }
      end

      private

      def decode_file(file)
        base64_data = file.split(",").last
        Base64.decode64(base64_data)
      end
    end
  end
end
