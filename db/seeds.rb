    # MAGIC ITEMS (split between magic shop and uncle bob)
    # Burma statue[15]
    # Canary's feathers[1]
    # Chicken's feet[1]
    # Cloven hooves[4]
    # Cloves[1]
    # Conjuring powder[4]
    # Crystal balls[4]
    # Dagger of Lex[7]
    # Essence of Slug candles[7]
    # Essence of rose thorn[1]
    # Essence of violet[1]
    # Eyeballs in honey[7]
    # Fleabane[5]
    # Green Egg Magazine[5]
    # Hand of Glory[4]
    # Hellebore[5]
    # Holy water[1]
    # Idol of Oofdar[16]
    # Janus' statue[9]
    # Khul's Amulet[10]
    # Lemon Seduction candles[7]
    # Monkey head[17]
    # Living Mummy Hand[7]
    # Petrified hamster[7]
    # Rabbit's foot[16]
    # Rats' eyes[1]
    # Raven's feathers[1]
    # Salamander eyes[5]
    # Set of runic tablets[1]
    # Sobekian Bloodstone[10]
    # Skink root[1]
    # Styx Water[17]
    # Sweet's talisman
    # Unicorn statue[3]
    # Urn of Ishtar[11]
    # Crosses and several other Catholic images[18]

    #Hellmouth Shop == monsters for purchase

    #Sunnydale high = memorabilia from school/city + season 1-3 inside jokes

    #Scooby Shop = purchase weapons, characters(heros and villains), inside jokes


Merchant.destroy_all
Discount.destroy_all
Item.destroy_all
OrderItem.destroy_all
Order.destroy_all
Review.destroy_all
User.destroy_all

# Merchants
hellmouth = Merchant.create!(name: 'The Hellmouth', address: '7349 Junction Avenue', city: 'Sunnydale', state: 'CA', zip: 90344)

magic_box = Merchant.create!(name: 'The Magic Box', address: '5124 Maple Court', city: 'Sunnydale', state: 'CA', zip: 90345)

uncle_bob = Merchant.create!(name: "Uncle Bob's Magic Cabinet", address: '5124 Maple Court', city: 'Sunnydale', state: 'CA', zip: 90345)

sunnydale_high = Merchant.create!(name: "The Sunnydale High Memorial Shop", address: '7340 Junction Avenue', city: 'Sunnydale', state: 'CA', zip: 90344)

scoobie_gang = Merchant.create!(name: "The Scoobie Gang", address: '1630 Revello Drive', city: 'Sunnydale', state: 'CA', zip: 90345)

# Discounts (called on merchants)

# Items
magic_box.items.create!(name: 'Bindweed', description: "Convolvus arvensis: Bindweed vines can be used for binding spells (including handfasting) and for creating “bridges” and connections between realms", price: 45, image: 'https://i.pinimg.com/originals/41/4d/70/414d70124d8e60fd5849c3fdf644b759.jpg', inventory: 20 )

magic_box.items.create!(name: 'A Treatise on the Mythology and Methodology of the Vampire Slayer', description: "This book details the history and power behind the vampire slayer and the watchers council", price: 195, image: 'https://st2.depositphotos.com/7926580/10666/i/950/depositphotos_106667708-stock-photo-old-ancient-book-with-golden.jpg', inventory: 3 )

uncle_bob.items.create!(name: 'Amulet of Caldys', description: "The Amulet of Caldys is a potent element whose true source of power is yet to be discovered", price: 2000, image: 'https://di2ponv0v5otw.cloudfront.net/posts/2018/09/03/5b8dee08e944bae50d35e07a/m_5b8dee21de6f621c19f8b2c8.jpg', active: true, inventory: 1 )

# Users (regular, merchant, and admin)

# Orders (called on users)

# Order Items (called on orders and include items)

# Reviews (called on items)
