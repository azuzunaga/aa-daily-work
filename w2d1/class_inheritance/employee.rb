require_relative 'manager'
class Employee
  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    self.salary_totalizer * multiplier
  end

  def salary_totalizer
    return self.salary unless self.is_a?(Manager)
    total_salary = self.salary + self.employees.reduce(0) do |total_sal, employee|
      total_sal + employee.salary_totalizer
    end
    total_salary
  end

end
