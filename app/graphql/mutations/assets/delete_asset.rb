module Mutations
  module Assets
    class DeleteAsset < Mutations::BaseMutation
      argumet :id, ID, require: true
      field :message, String, null: false
      field :errors, [ String ], null: false

      def resolve(id:, asset:)
        begin
          existing_asset = Asset.find(id)
          if existing_asset.destroy
          { message: "Asset Destroyed successfully", errors: [] }
          else
            { message: "", errors: existing_asset.errors.full_messages }
          end
        rescue ActiveRecord::RecordNotFound => e
          { message: "Failed to Destroy message", errors: [ e.message ] }
        end
      end
    end
  end
end
