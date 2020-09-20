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
magic_discount = magic_box.discounts.create!(description:"Buy 5 items, get 10% off", quantity:5, percent:10)
sunnydale_discount_1 = sunnydale_high.discounts.create!(description:"Buy 5 items, get 20% off", quantity:5, percent:20)
sunnydale_discount_2 = sunnydale_high.discounts.create!(description:"Buy 10 items, get 35% off", quantity:10, percent:35)
scooby_discount_1 = scooby_gang.discounts.create!(description:"Buy 5 items, get 15% off", quantity:5, percent:15)
scooby_discount_2 = scooby_gang.discounts.create!(description:"Buy 15 items, get 35% off", quantity:15, percent:35)
scooby_discount_3 = scooby_gang.discounts.create!(description:"Buy 25 items, get 50% off", quantity:25, percent:50)

# Items (called on merchants)
  #magic items
bindweed = magic_box.items.create!(name: 'Bindweed', description: "Convolvus arvensis: Bindweed vines can be used for binding spells (including handfasting) and for creating “bridges” and connections between realms", price: 15, image: 'https://i.pinimg.com/originals/41/4d/70/414d70124d8e60fd5849c3fdf644b759.jpg', inventory: 200 )
vampire_book = magic_box.items.create!(name: 'A Treatise on the Mythology and Methodology of the Vampire Slayer', description: "This book details the history and power behind the vampire slayer and the watchers council", price: 195, image: 'https://st2.depositphotos.com/7926580/10666/i/950/depositphotos_106667708-stock-photo-old-ancient-book-with-golden.jpg', inventory: 30 )
holy_water = magic_box.items.create!(name: 'Holy water', description: "", price: N, image: '', inventory: N )
urn = magic_box.items.create!(name: 'Urn of Ishtar', description: "", price: N, image: '', inventory: N )
horn = magic_box.items.create!(name: 'Unicorn Horn', description: "", price: N, image: '', active: false, inventory: N )

amulet = uncle_bob.items.create!(name: 'Amulet of Caldys', description: "The Amulet of Caldys is a potent element whose true source of power is yet to be discovered", price: 2000, image: 'https://di2ponv0v5otw.cloudfront.net/posts/2018/09/03/5b8dee08e944bae50d35e07a/m_5b8dee21de6f621c19f8b2c8.jpg', active: false, inventory: 1 )
hellebore = uncle_bob.items.create!(name: 'Hellebore', description: "", price: N, image: '', active: false, inventory: N )

  # Monster items
vampire = hellmouth.items.create!(name: 'Vampire', description: "Blood sucking undead demons who look humanoid", price: 50, image: 'https://vignette.wikia.nocookie.net/buffy/images/e/ec/The_Shroud_of_Rahmon_Kate_Angel_02.jpg/revision/latest?cb=20190423061440', inventory: 1500 )
vengeance = hellmouth.items.create!(name: 'Vengeance Demon', description: "A society of powerful demons originating from the dimension Arashmaharr, who had the power of granting wishes of vengeful intent", price: 1495, image: 'https://vignette.wikia.nocookie.net/buffy/images/9/95/The_Wish_Anya_01.jpg/revision/latest?cb=20190824184649', inventory: 345 )
gentleman = hellmouth.items.create!(name: 'The Gentleman', description: "A group of demons said to originate from fairytales. They roamed from town to town, seeking out seven human hearts they required to stay alive.", price: 5400, image: 'https://vignette.wikia.nocookie.net/buffy/images/3/33/Gentlemen.jpg/revision/latest?cb=20091119193213', inventory: 13 )
master = hellmouth.items.create!(name: 'The Master', description: "A powerful and respected vampire, older than any other on record.[2] He was the leader of the Order of Aurelius, a vampire cult that worshiped the Old Ones and sought to bring about their return to the world.", price: 3115, image: 'https://vignette.wikia.nocookie.net/buffy/images/3/33/1x10_006.jpg/revision/latest/scale-to-width-down/663?cb=20171103002502', active: false, inventory: 24 )

  #Sunnydale Memorabilia
snake = sunnydale_high.items.create!(name: 'Olvikan', description: "Olvikan is a snake-like old one: pure-breed demons that dominated Earth before humans, during the Primordium Age.", price: 10000, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/26/Olvikan.png/revision/latest?cb=20160102232219', inventory: 7 )
trophy = sunnydale_high.items.create!(name: 'Cheerleader Trophy', description: "This haunted trophy holds the soul of Catherine Madison, a witch who attempted to steal her daughters body to relive her glory days as a cheerleader", price: 350, image: 'https://vignette.wikia.nocookie.net/buffy/images/d/d5/03_51.jpg/revision/latest/scale-to-width-down/340?cb=20081025111301', inventory: 6 )
hell_spawn = sunnydale_high.items.create!(name: 'Hellmouth Spawn', description: "A massive, tentacled demon that dwelled on the other side of a portal that opened when The Master ascended", price: 1678, image: 'https://vignette.wikia.nocookie.net/buffy/images/1/16/00dd4kg7-1-.jpg/revision/latest?cb=20110528105252', active: false, inventory: 2 )
bezoar = sunnydale_high.items.create!(name: 'Bezoar', description: "A prehistoric parasite whose offspring were capable of attaching themselves to other creatures and taking control of their motor functions via neural clamping.", price: 450, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/23/Buffy212-bezoar1.jpg/revision/latest/scale-to-width-down/180?cb=20081011195105', active: false, inventory: 64 )

  #Scooby Gang (characters, weapons, etc)
buffy = scooby_gang.items.create!(name: 'Buffy Summers', description: "A Slayer who was activated in the late 20th century", price: 2000, image: 'https://vignette.wikia.nocookie.net/buffy/images/9/92/C1.jpg/revision/latest/scale-to-width-down/700?cb=20130212141636', inventory: 5 )
willow = scooby_gang.items.create!(name: 'Willow Rosenberg', description: "One of the founding members of the Scooby Gang - a powerful witch in her own right", price: 1800, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/2d/B4_Willow_02.jpg/revision/latest/scale-to-width-down/700?cb=20171029050235', inventory: 10 )
xander = scooby_gang.items.create!(name: 'Xander Harris', description: "One of the founding members of the Scooby Gang - Xander is the grounding force that allows the gang to see beyond the supernatural", price: 1800, image: 'https://vignette.wikia.nocookie.net/buffy/images/6/6a/S6_058_Xander.jpg/revision/latest/scale-to-width-down/700?cb=20190430164507', inventory: 10 )
rupert = scooby_gang.items.create!(name: 'Rupert Giles', description: "A former watcher; a father figure to Buffy Summers", price: 2500, image: 'https://vignette.wikia.nocookie.net/buffy/images/9/97/1rupert_giles.jpg/revision/latest/scale-to-width-down/680?cb=20190405012349', inventory: 2 )
cordy = scooby_gang.items.create!(name: 'Cordelia Chase', description: "Once a popular cheerleader, now an agent of the Powers That Be and a warrior champion", price: 1000, image: 'https://vignette.wikia.nocookie.net/buffy/images/f/fd/AS2_017_Cordelia.jpg/revision/latest?cb=20190124021639', inventory: 20 )
angel = scooby_gang.items.create!(name: 'Angel', description: "One of the most well-known vampires in all of vampiric history, legendary for both his savage villainy and his great heroism. ", price: 1500, image: 'https://vignette.wikia.nocookie.net/buffy/images/3/35/A2_Angel_02.jpg/revision/latest?cb=20120811122656', active: false, inventory: 3 )
stake = scooby_gang.items.create!(name: 'Mr. Pointy', description: "The stake Kendra Young gave Buffy Summers.", price: 60, image: 'https://vignette.wikia.nocookie.net/buffy/images/5/51/Kendra_Mr_Pointy.png/revision/latest/scale-to-width-down/350?cb=20180712171700', inventory: 100 )
scythe = scooby_gang.items.create!(name: 'Scythe', description: "An ancient weapon designed for the Slayer, embodying their mystical essence.", price: 6000, image: 'https://vignette.wikia.nocookie.net/buffy/images/f/f7/End_of_Days_Buffy_02.jpg/revision/latest/scale-to-width-down/333?cb=20190929182633', inventory: 3 )
cross = scooby_gang.items.create!(name: 'Cross Necklace', description: "Buffy Summers owned a cross necklace gifted by Angel when the two first met.", price: 25, image: 'https://vignette.wikia.nocookie.net/buffy/images/d/d6/Buffy_cross_necklace.png/revision/latest/scale-to-width-down/350?cb=20180228182354', inventory: 500 )
knife = scooby_gang.items.create!(name: "Faith's Knife", description: "Faith Lehane owned a knife given by Richard Wilkins.", price: 250, image: 'https://vignette.wikia.nocookie.net/buffy/images/2/29/Faithknife2.jpg/revision/latest/scale-to-width-down/350?cb=20190321000443', inventory: 20 )
bullet = scooby_gang.items.create!(name: "Silver Bullet", description: "A bullet made of silver, used as ammunition in a firearm such as a gun- good against werewolves", price: 35, image: 'https://vignette.wikia.nocookie.net/buffy/images/6/67/Cain.jpg/revision/latest/scale-to-width-down/350?cb=20100312203934', inventory: 150 )

# Users (regular, merchant, and admin)
  #at least 3 regular users
user_tim = User.create!(name: 'Tim', address: '456 There Blvd', city: 'Sunnydale', state: 'CA', zip: 90244, email: 'tim@user.com', password: 'user')
user_brian = User.create!(name: 'Brian', address: '789 Here St', city: 'Sunnydale', state: 'CA', zip: 90245, email: 'brian@user.com', password: 'user')
user_kat = User.create!(name: 'Kat', address: '963 Everywhere Place', city: 'Sunnydale', state: 'CA', zip: 90234, email: 'kat@user.com', password: 'user')
user_mike = User.create!(name: 'Mike', address: '852 Upside Ave', city: 'Sunnydale', state: 'CA', zip: 90235, email: 'mike@user.com', password: 'user')

  #at least 2 merchant users
anya = magic_box.users.create(name: 'Anya Jenkins', address: '123 Main St', city: 'Sunnydale', state: 'CA', zip: 90245, email: 'anya@merchant.com', password: 'merchant')
dawn = scooby_gang.users.create(name: 'Dawn Summers', address: '1680 Robello Dr', city: 'Sunnydale', state: 'CA', zip: 90235, email: 'dawn@merchant.com', password: 'merchant')

  #at least 1 admin
admin = User.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'admin@admin.com', password: 'admin', role: :admin)

# Orders (called on users)
  #two distinct users have orders
  #at least one user has multiple orders
  #at least one user has a cancelled order

# Order Items (called on orders and include items)

# Reviews (called on items)

  #at least one review per merchant shop
  #at least one item has three reviews
