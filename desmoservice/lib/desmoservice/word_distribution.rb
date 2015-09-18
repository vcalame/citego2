module Desmoservice
class WordDistribution

  attr_reader :words, :tagged_terms
  
  def initialize
    @words = Hash.new
    @tagged_terms = Hash.new
  end
  
  def parse_json(json_string)
    data = JSON.parse(json_string)
    if data.has_key?('lexiedistribution')
      if data['lexiedistribution'].has_key?('lexieArray')
        data['lexiedistribution']['lexieArray'].each do |v|
          word = Word.new(v['id'], v['value'])
          v['codeArray'].each {|id| word.term_ids << id}
          @words[word.id] = word
        end
      end
      if data['lexiedistribution'].has_key?('sourceMap')
        data['lexiedistribution']['sourceMap'].each_value do |v|
          tagged_term = TaggedTerm.new(v)
          @tagged_terms[tagged_term.id] = tagged_term
        end
      end
    end
  end

end

class Word
  
  attr_reader :id, :value, :term_ids
  
  def initialize(id, value)
    @id = id
    @value = value
    @term_ids = Array.new
  end
end

class TaggedTerm < Term
  
  attr_reader :tagged_parts
  
  def initialize(data)
    super(data['descripteur'])
    @tagged_parts = Array.new
    data['text'].each do |v|
      if v.respond_to?('has_key?')
        @tagged_parts << TaggedPart.new(v['lexie'], v['value'])
      else
        @tagged_parts << TaggedPart.new(nil, v)
      end
    end
  end
  
end

class TaggedPart
  
  attr_reader :word_id, :value
  
  def initialize(word_id, value)
    @word_id = word_id
    @value = value
  end
  
end
end