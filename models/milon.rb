require_relative '../milon/parser'
class MilonModel
  def self.translate word
    return ::Parser.translate word
  end
end
