class AdUnit < ActiveHash::Base
  fields :id, :unit

  create id:  0, unit: 1717409875
  create id:  1, unit: 1298607478
  create id:  2, unit: 8682273472
  create id:  3, unit: 2635849070
  create id:  4, unit: 2551100271
  create id:  5, unit: 2481073070
  create id:  6, unit: 7065308278
  create id:  7, unit: 2655349078
  create id:  8, unit: 8113994274
  create id:  9, unit: 7066048677
  create id: 10, unit: 1213967877
  create id: 11, unit: 7205727471
  create id: 12, unit: 9737093877
  create id: 13, unit: 9178690672
  create id: 14, unit: 9989918276
  create id: 15, unit: 1220670557
  create id: 16, unit: 6426811070
  create id: 17, unit: 7903544277
  create id: 18, unit: 9380277476
  create id: 19, unit: 1857010671
  create id: 20, unit: 4810477079
  create id: 21, unit: 3194143077
  create id: 22, unit: 7763943475
  create id: 23, unit: 9240676671

  create id: 97, unit: 8736983874
  create id: 98, unit: 4171805877
  create id: 99, unit: 3256867075

  def self.current
    find(Time.zone.now.hour).unit
  end
end
