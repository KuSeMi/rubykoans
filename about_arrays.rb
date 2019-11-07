require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrays < Neo::Koan
  def test_creating_arrays
    empty_array = Array.new
    assert_equal Array, empty_array.class
    assert_equal 0, empty_array.size
  end

  # array.size тоже что  .length, возвращают длину массива

  def test_array_literals
    array = Array.new
    assert_equal [], array

    array[0] = 1
    assert_equal [1], array

    array[1] = 2
    assert_equal [1, 2], array

    array << 333 # добавляет элемент в массив
    assert_equal [1, 2, 333], array
    #  <<  удобный способ добавить элемент в массив
  end

  def test_accessing_array_elements
    array = [:peanut, :butter, :and, :jelly]

    assert_equal :peanut, array[0]
    assert_equal :peanut, array.first
    assert_equal :jelly, array[3]
    assert_equal :jelly, array.last
    assert_equal :jelly, array[-1]
    assert_equal :butter, array[-3]

    # доступ с отрицательными числами идет в обратном порядке от конца, поэтому
    # -1 получает последний элемент, -2 - второй и т. Д.
  end

  def test_slicing_arrays
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut], array[0,1]
    assert_equal [:peanut, :butter], array[0,2]
    assert_equal [:and, :jelly], array[2,2]
    assert_equal [:and, :jelly], array[2,20]
    assert_equal [], array[4,0]
    assert_equal [], array[4,100]
    assert_equal nil, array[5,0]
  end

  # http://stackoverflow.com/questions/3219229/why-does-array-slice-behave-differently-for-length-n

  def test_arrays_and_ranges
    assert_equal Range, (1..5).class
    assert_not_equal [1,2,3,4,5], (1..5)
    assert_equal [1, 2, 3, 4, 5], (1..5).to_a
    assert_equal [1, 2, 3, 4], (1...5).to_a
  end

  # Диапазон с .. означает включительно, поэтому 1..4 означает 1,2,3,4
  # тогда как ... включает в себя все, кроме последнего элемента, поэтому 1 ... 4 означает 1,2,3

  def test_slicing_with_ranges
    array = [:peanut, :butter, :and, :jelly]

    assert_equal [:peanut, :butter, :and], array[0..2]
    assert_equal [:peanut, :butter], array[0...2]
    assert_equal [:and, :jelly], array[2..-1]
  end

  def test_pushing_and_popping_arrays
    array = [1,2]
    array.push(:last)

    assert_equal [1,2,:last], array

    popped_value = array.pop
    assert_equal :last, popped_value
    assert_equal [1,2], array
  end

  # pop метод удаляет последний элемент, shift удаляет первый
  # unshift метод добавляет элемент в начало массива
  
  def test_shifting_arrays
    array = [1,2]
    array.unshift(:first)

    assert_equal [:first, 1,2], array

    shifted_value = array.shift
    assert_equal :first, shifted_value
    assert_equal [1,2], array
  end

end
