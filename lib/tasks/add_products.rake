# namespace :db do
#   desc "This task will be add new products"
#   task :add_products do
#     ProductsCreater.attributes!

#     class ProductsCreater
#         def persist!
#           puts "Количество продуктов до: #{Product.count}"
#           # 10.times do |i|
#           #   puts "\n"
#           #   puts "[ Добавляю продукт ]"
#           #   attrs = attributes
#           #   puts " [ Атрибуты ] #{attrs}"
#           #   Product.create(attrs)
#           # end
#           # puts "Количество продуктов после: #{Product.count}"
#         end

#         def attributes
#           {
#             title: Faker::Commerce.product_name,
#             price: Faker::Commerce.price,
#             description: Faker::Lorem.paragraph(2),
#             image_url: Faker::Company.logo
#           }
#         end

#       end

#     end
#   end
# end
