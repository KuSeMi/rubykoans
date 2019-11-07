require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John", "Smith"], names
  end

  #https://ru.hexlet.io/courses/ruby/lessons/arrays/theory_unit

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  # a, b = b, a
  # очень удобный и простой способ поменять значения, которые потребовали бы временной
  # переменной на другом языке, поэтому нам нужно сделать что-то вроде:
  # var a = 1;
  # var b = 2;
  # var temp = a;
  # a = b;
  # b = temp;
  # Параллельное назначение

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end


  # если бы это было first_name, last_name, other_name, тогда other_name было бы "III"

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal ["Smith","III"], last_name
  end

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    assert_equal "Cher", first_name
    assert_equal nil, last_name
  end

  # нет соответствующего второго элемента в массиве, так что он имеет nil 

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"]
    assert_equal "John", first_name
  end

  # помните, что порядок назначения, определенный слева, соответствует массиву
  # справа

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
end
