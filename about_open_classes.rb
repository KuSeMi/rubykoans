require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutOpenClasses < Neo::Koan
  #https://codingbee.net/ruby/ruby-open-classes-and-monkey-patching
  class Dog
    def bark
      "WOOF"
    end
  end

  def test_as_defined_dogs_do_bark
    fido = Dog.new
    assert_equal "WOOF", fido.bark
  end

  # ------------------------------------------------------------------
  # В Ruby классы никогда не закрываются: вы всегда можете добавить методы в существующий класс.
  # Это относится как к классам, которые вы пишете, так и к стандартным встроенным классам. 
  # Все, что вам нужно сделать, это открыть определение класса для существующего класса, 
  # и новое указанное вами содержимое будет добавлено во все, что там есть.

  # Open the existing Dog class and add a new method.
  class Dog
    def wag
      "HAPPY"
    end
  end

  def test_after_reopening_dogs_can_both_wag_and_bark
    fido = Dog.new
    assert_equal "HAPPY", fido.wag
    assert_equal "WOOF", fido.bark
  end

  # ------------------------------------------------------------------
  # Если вы пишете новый метод, который концептуально принадлежит исходному классу, 
  # вы можете снова открыть класс и добавить свой метод в определение класса. 
  # Это следует делать только в том случае, если ваш метод в целом полезен, 
  # и вы уверены, что он не будет конфликтовать с методом, определенным какой-либо библиотекой, 
  # которую вы включите в будущем. Если ваш метод, как правило, 
  # бесполезен или вы не хотите рисковать изменением класса после его первоначального создания, 
  # создайте подкласс исходного класса. Подкласс может переопределить методы своего родителя 
  # или добавить новые. Это безопаснее, потому что исходный класс и любой код, 
  # который зависит от него, не затронуты.

  class ::Integer
    def even?
      (self % 2) == 0
    end
  end

  def test_even_existing_built_in_classes_can_be_reopened
    assert_equal false, 1.even?
    assert_equal true, 2.even?
  end

  # NOTE: To understand why we need the :: before Integer, you need to
  # become enlightened about scope.
end
