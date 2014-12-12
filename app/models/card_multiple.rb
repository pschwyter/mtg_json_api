class CardMultiple
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :user
  
  field :tradeable_copies, type: Array
  field :wanted_copies, type: Array

# [29] pry(main)> u = User.first
# => #<User _id: 548757b8506869477b000000, tradeable_card_ids: [BSON::ObjectId('54875af6506869477b020000'), BSON::ObjectId('548784a45068694db3000100')], wanted_card_ids: [BSON::ObjectId('548784a45068694db3000100')], first_name: "Phil", last_name: nil, email: nil, dci_number: nil, password_digest: nil, tradeable_cards_ids: [BSON::ObjectId('548765da506869483aaa0000'), BSON::ObjectId('548765e6506869483aab0000')]>
# [30] pry(main)> cm = CardMultiple.create
# => #<CardMultiple _id: 548a34d65068692980030000, user_id: nil, tradeable_copies: nil, wanted_copies: nil>
# [31] pry(main)> cm.user = u
# => #<User _id: 548757b8506869477b000000, tradeable_card_ids: [BSON::ObjectId('54875af6506869477b020000'), BSON::ObjectId('548784a45068694db3000100')], wanted_card_ids: [BSON::ObjectId('548784a45068694db3000100')], first_name: "Phil", last_name: nil, email: nil, dci_number: nil, password_digest: nil, tradeable_cards_ids: [BSON::ObjectId('548765da506869483aaa0000'), BSON::ObjectId('548765e6506869483aab0000')]>
# [32] pry(main)> u
# => #<User _id: 548757b8506869477b000000, tradeable_card_ids: [BSON::ObjectId('54875af6506869477b020000'), BSON::ObjectId('548784a45068694db3000100')], wanted_card_ids: [BSON::ObjectId('548784a45068694db3000100')], first_name: "Phil", last_name: nil, email: nil, dci_number: nil, password_digest: nil, tradeable_cards_ids: [BSON::ObjectId('548765da506869483aaa0000'), BSON::ObjectId('548765e6506869483aab0000')]>
# [33] pry(main)> u.card_multiple
# => #<CardMultiple _id: 548a34d65068692980030000, user_id: BSON::ObjectId('548757b8506869477b000000'), tradeable_copies: nil, wanted_copies: nil>
# [34] pry(main)> u.card_multiple.tradeable_copies
# => nil
# [35] pry(main)> u.card_multiple.tradeable_copies = []
# => []
# [36] pry(main)> u_t_copies =  u.card_multiple.tradeable_copies
# => []
# [37] pry(main)> u_t_copies
# => []
# [38] pry(main)> c = Card.first
# => #<Card _id: 548784a45068694db3000100, card_set_id: BSON::ObjectId('548784a45068694db3000000'), tradeable_by_ids: [BSON::ObjectId('548757b8506869477b000000'), BSON::ObjectId('548a09d35068691a4d000000')], wanted_by_ids: [BSON::ObjectId('548757b8506869477b000000')], layout: "normal", type: "Sorcery", types: ["Sorcery"], colors: ["Green"], multiverseid: 176, name: "Tranquility", cmc: 3, rarity: "Common", artist: "Douglas Shuler", manaCost: "{2}{G}", text: "Destroy all enchantments.", imageName: "tranquility", user_ids: [BSON::ObjectId('548757b8506869477b000000')], blah: []>
# [39] pry(main)> c.to_s
# => "#<Card:0x007fbc6e8ae418>"
# [40] pry(main)> c = Card.first
# => #<Card _id: 548784a45068694db3000100, card_set_id: BSON::ObjectId('548784a45068694db3000000'), tradeable_by_ids: [BSON::ObjectId('548757b8506869477b000000'), BSON::ObjectId('548a09d35068691a4d000000')], wanted_by_ids: [BSON::ObjectId('548757b8506869477b000000')], layout: "normal", type: "Sorcery", types: ["Sorcery"], colors: ["Green"], multiverseid: 176, name: "Tranquility", cmc: 3, rarity: "Common", artist: "Douglas Shuler", manaCost: "{2}{G}", text: "Destroy all enchantments.", imageName: "tranquility", user_ids: [BSON::ObjectId('548757b8506869477b000000')], blah: []>
# [41] pry(main)> c.id
# => BSON::ObjectId('548784a45068694db3000100')
# [42] pry(main)> c_id = c.id
# => BSON::ObjectId('548784a45068694db3000100')
# [43] pry(main)> c_id.to_s
# => "548784a45068694db3000100"
# [44] pry(main)> u_t_copies << c_id.to_s
# => ["548784a45068694db3000100"]
# [45] pry(main)> u_t_copies << c_id.to_s
# => ["548784a45068694db3000100", "548784a45068694db3000100"]
# [46] pry(main)> u_t_copies << c_id.to_s
# => ["548784a45068694db3000100", "548784a45068694db3000100", "548784a45068694db3000100"]
# [47] pry(main)> u_t_copies.group_by { |id| id}
# => {"548784a45068694db3000100"=>["548784a45068694db3000100", "548784a45068694db3000100", "548784a45068694db3000100"]}
# [48] pry(main)> u_t_copies.group_by { |id| id}.values
# => [["548784a45068694db3000100", "548784a45068694db3000100", "548784a45068694db3000100"]]
# [49] pry(main)> u_t_copies.group_by { |id| id}.values

end
