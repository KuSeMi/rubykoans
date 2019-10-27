require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbols_can_be_compared
    symbol1 = :a_symbol
    symbol2 = :a_symbol
    symbol3 = :something_else

    assert_equal true, symbol1 == symbol2
    assert_equal false, symbol1 == symbol3
  end

# Символ Ruby - это постоянное уникальное имя, и оно не может быть изменено

  def test_identical_symbols_are_a_single_internal_object
    symbol1 = :a_symbol
    symbol2 = :a_symbol

    assert_equal true, symbol1           == symbol2
    assert_equal true, symbol1.object_id == symbol2.object_id
  end

  # В отличие от строк, символы с одинаковыми именами инициализируются и существуют в памяти
  # только один раз за сеанс ruby. Символы наиболее полезны, когда
  # вы собираетесь повторно использовать строки, представляющие что-то еще.
  # даже если символ использовался как ключ в двух разных хешах, они все еще
  # один и тот же объект, так, например, ключи Patient1 и Patient2 = :ruby будут тем же объектом

  # patient1 = { :ruby => "red" }
  # patient2 = { :ruby => "testing" }
  # patient1.each_key {|key| puts key.object_id.to_s]
  # patient2.each_key {|key| puts key.object_id.to_s}
  # оба результата 3918094, так что это один и тот же объект
  
  # Два символа с одинаковым именем всегда являются одним и тем же базовым объектом:
  #  "open".object_id != "open".object_id 
  #  :open.object_id == :open.object_id

  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
    assert_equal true, symbols_as_strings.include?("test_method_names_become_symbols")
  end

  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?
   
  # Потому что символы не являются строками, поэтому мы должны преобразовать их в строки, чтобы сделать
  # сравнения строки по значениям. Более поздний тест показывает, что с помощью .eql? не работает

  # Советы
  # (1) Если важно содержимое (то есть последовательность символов) объекта, используйте строку.
  # (2) Если важна личность объекта, используйте Символ.

  in_ruby_version("mri") do
    RubyConstant = "What is the sound of one hand clapping?"
    def test_constants_become_symbols
      all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

      assert_equal false, all_symbols_as_strings.include?(RubyConstant)
    end
  end

  def test_symbols_can_be_made_from_strings
    string = "catsAndDogs"
    assert_equal :catsAndDogs, string.to_sym
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal symbol.to_sym, symbol
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal symbol.to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal "It is raining cats and dogs.", string
  end

  def test_symbols_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?("ruby")
  end

  # Символы не являются строками, но их можно преобразовать с помощью .to_s и наоборот,
  # где строки могут быть преобразованы в символы с помощью .to_sym

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_char)
    assert_equal false, symbol.respond_to?(:reverse)
  end

  # It's important to realize that symbols are not "immutable
  # strings", though they are immutable. None of the
  # interesting string operations are available on symbols.

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    assert_raise(NoMethodError) do
      :cats + :dogs
    end
  end

  # в то время как символы не могут быть объединены, вы можете преобразовать их в строку, объединить
  # строки и строки  преобразовать в символ, например:
  # puts (:test1.to_s + " " + :test2.to_s).to_sym
  # puts :"test1 test2".is_a?(Symbol)

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?

  # Создание большого количества символов динамически распределяет много памяти, которая не может быть
  # освобождается до завершения программы. Символы Ruby помещаются в память только один раз, поэтому они
  # очень эффективны для таких вещей, как хэш-ключи.
end
