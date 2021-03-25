class Esd < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '1〜2日で発送' },
    { id: 2, name: "2\b〜3日で発送" },
    { id: 3, name: "4\b〜7日で発送" }
  ]
  include ActiveHash::Associations
  has_many :items
end
