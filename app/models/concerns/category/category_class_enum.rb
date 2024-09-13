module Category::CategoryClassEnum
  extend ActiveSupport::Concern

   CATEGORY = {
     assets: "assets",
     product: "product"
   }.freeze

   included do
     enum category_class: CATEGORY
   end
end
