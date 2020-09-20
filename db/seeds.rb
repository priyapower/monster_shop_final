Merchant.destroy_all
Discount.destroy_all
Item.destroy_all
OrderItem.destroy_all
Order.destroy_all
Review.destroy_all
User.destroy_all

# Merchants
magic_box = Merchant.create!(name: 'The Magic Box', address: '5124 Maple Court', city: 'Sunnydale', state: 'CA', zip: 90345)

uncle_bob = Merchant.create!(name: "Uncle Bob's Magic Cabinet", address: '5124 Maple Court', city: 'Sunnydale', state: 'CA', zip: 90345)

hellmouth = Merchant.create!(name: 'The Hellmouth', address: '7349 Junction Avenue', city: 'Sunnydale', state: 'CA', zip: 90344)

sunnydale_high = Merchant.create!(name: "The Sunnydale High Memorial Shop", address: '7340 Junction Avenue', city: 'Sunnydale', state: 'CA', zip: 90344)

scooby_gang = Merchant.create!(name: "The Scooby Gang", address: '1630 Revello Drive', city: 'Sunnydale', state: 'CA', zip: 90345)

# Discounts (called on merchants)
  #magic box discount
  #sunnydale high discount
  #sunnydale high discount
  #scooby gang discount
  #scooby gang discount
  #scooby gang discount

# Items
  #magic items
magic_box.items.create!(name: 'Bindweed', description: "Convolvus arvensis: Bindweed vines can be used for binding spells (including handfasting) and for creating “bridges” and connections between realms", price: 15, image: 'https://i.pinimg.com/originals/41/4d/70/414d70124d8e60fd5849c3fdf644b759.jpg', inventory: 200 )

magic_box.items.create!(name: 'A Treatise on the Mythology and Methodology of the Vampire Slayer', description: "This book details the history and power behind the vampire slayer and the watchers council", price: 195, image: 'https://st2.depositphotos.com/7926580/10666/i/950/depositphotos_106667708-stock-photo-old-ancient-book-with-golden.jpg', inventory: 30 )

magic_box.items.create!(name: 'Holy water', description: "", price: N, image: '', inventory: N )
magic_box.items.create!(name: 'Urn of Ishtar', description: "", price: N, image: '', inventory: N )
magic_box.items.create!(name: 'Unicorn Horn', description: "", price: N, image: '', active: false, inventory: N )

uncle_bob.items.create!(name: 'Amulet of Caldys', description: "The Amulet of Caldys is a potent element whose true source of power is yet to be discovered", price: 2000, image: 'https://di2ponv0v5otw.cloudfront.net/posts/2018/09/03/5b8dee08e944bae50d35e07a/m_5b8dee21de6f621c19f8b2c8.jpg', active: false, inventory: 1 )
uncle_bob.items.create!(name: 'Hellebore', description: "", price: N, image: '', active: false, inventory: N )

  # Monster items
hellmouth.items.create!(name: 'Vampire', description: "Blood sucking undead demons who look humanoid", price: 50, image: 'https://vignette.wikia.nocookie.net/buffy/images/e/ec/The_Shroud_of_Rahmon_Kate_Angel_02.jpg/revision/latest?cb=20190423061440', inventory: 1500 )
hellmouth.items.create!(name: 'Vengeance Demon', description: "A society of powerful demons originating from the dimension Arashmaharr, who had the power of granting wishes of vengeful intent", price: 1495, image: 'https://vignette.wikia.nocookie.net/buffy/images/9/95/The_Wish_Anya_01.jpg/revision/latest?cb=20190824184649', inventory: 345 )
hellmouth.items.create!(name: 'Gentleman', description: "A group of demons said to originate from fairytales. They roamed from town to town, seeking out seven human hearts they required to stay alive.", price: 5400, image: 'https://vignette.wikia.nocookie.net/buffy/images/3/33/Gentlemen.jpg/revision/latest?cb=20091119193213', inventory: 13 )
hellmouth.items.create!(name: 'The Master', description: "A powerful and respected vampire, older than any other on record.[2] He was the leader of the Order of Aurelius, a vampire cult that worshiped the Old Ones and sought to bring about their return to the world.", price: 3115, image: 'https://vignette.wikia.nocookie.net/buffy/images/3/33/1x10_006.jpg/revision/latest/scale-to-width-down/663?cb=20171103002502', active: false, inventory: 24 )

  #Sunnydale Memorabilia
sunnydale_high.items.create!(name: 'Olvikan', description: "Olvikan is a snake-like old one: pure-breed demons that dominated Earth before humans, during the Primordium Age.", price: 10000, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/26/Olvikan.png/revision/latest?cb=20160102232219', inventory: 7 )
sunnydale_high.items.create!(name: 'Cheerleader Trophy', description: "This haunted trophy holds the soul of Catherine Madison, a witch who attempted to steal her daughters body to relive her glory days as a cheerleader", price: 350, image: 'https://vignette.wikia.nocookie.net/buffy/images/d/d5/03_51.jpg/revision/latest/scale-to-width-down/340?cb=20081025111301', inventory: 6 )
sunnydale_high.items.create!(name: 'Hellmouth Spawn', description: "A massive, tentacled demon that dwelled on the other side of a portal that opened when The Master ascended", price: 1678, image: 'https://vignette.wikia.nocookie.net/buffy/images/1/16/00dd4kg7-1-.jpg/revision/latest?cb=20110528105252', active: false, inventory: 2 )
sunnydale_high.items.create!(name: 'Bezoar', description: "A prehistoric parasite whose offspring were capable of attaching themselves to other creatures and taking control of their motor functions via neural clamping.", price: 450, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/23/Buffy212-bezoar1.jpg/revision/latest/scale-to-width-down/180?cb=20081011195105', active: false, inventory: 64 )

  #Scooby Gang (characters, weapons, etc)
scooby_gang.items.create!(name: 'Buffy Summers', description: "", price: N, image: '', inventory: N )
scooby_gang.items.create!(name: 'Willow Rosenberg', description: "", price: N, image: '', inventory: N )
scooby_gang.items.create!(name: 'Xander Harris', description: "", price: N, image: '', inventory: N )
scooby_gang.items.create!(name: 'Rubert Giles', description: "", price: N, image: '', inventory: N )
scooby_gang.items.create!(name: 'Cordelia Chase', description: "", price: N, image: '', inventory: N )
scooby_gang.items.create!(name: 'Angel', description: "", price: N, image: '', active: false, inventory: N )
scooby_gang.items.create!(name: 'Mr. Pointy', description: "The stake Kendra Young gave Buffy Summers.", price: 60, image: 'https://vignette.wikia.nocookie.net/buffy/images/5/51/Kendra_Mr_Pointy.png/revision/latest/scale-to-width-down/350?cb=20180712171700', inventory: 100 )
scooby_gang.items.create!(name: 'Scythe', description: "An ancient weapon designed for the Slayer, embodying their mystical essence.", price: 6000, image: 'https://vignette.wikia.nocookie.net/buffy/images/f/f7/End_of_Days_Buffy_02.jpg/revision/latest/scale-to-width-down/333?cb=20190929182633', inventory: 3 )
scooby_gang.items.create!(name: 'Cross Necklace', description: "Buffy Summers owned a cross necklace gifted by Angel when the two first met.", price: 25, image: 'https://vignette.wikia.nocookie.net/buffy/images/d/d6/Buffy_cross_necklace.png/revision/latest/scale-to-width-down/350?cb=20180228182354', inventory: 500 )
scooby_gang.items.create!(name: "Faith's Knife", description: "Faith Lehane owned a knife given by Richard Wilkins.", price: 250, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/29/Faithknife2.jpg/revision/latest/scale-to-width-down/350?cb=20190321000443', inventory: 20 )
scooby_gang.items.create!(name: "Silver Bullet", description: "A bullet made of silver, used as ammunition in a firearm such as a gun- good against werewolves", price: 35, image: 'https://vignette.wikia.nocookie.net/buffy/images/6/67/Cain.jpg/revision/latest/scale-to-width-down/350?cb=20100312203934', inventory: 150 )

# Users (regular, merchant, and admin)

# Orders (called on users)

# Order Items (called on orders and include items)

# Reviews (called on items)
