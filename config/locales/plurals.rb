{
  ru: {
    i18n: {
      plural: {
        keys: [:one, :few, :many, :other],
        rule: lambda do |n|
          return :other if n.is_a? Float

          n = -n if n < 0
          mod10 = n % 10
          mod100 = n % 100

          return :many if mod10.zero? || mod10.between?(5, 9) || mod100.between?(11, 20)
          return :one  if mod10 == 1
          return :few  if mod10.between? 2, 4
        end
      }
    }
  }
}
