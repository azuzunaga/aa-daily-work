require_relative 'db_connection'
require "active_support/inflector"
require "active_support/core_ext/regexp"

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.


class SQLObject

  def self.columns
    table = self.table_name

    @columns ||= DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{table}
    SQL
    .first.map(&:intern)

    @columns
  end

  def self.finalize!
    self.columns

    @columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method("#{column}=") do |arg|
        self.attributes[column] = arg
      end

    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    results = DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL

    # self.class.parse_all(results)
    results
  end

  def self.parse_all(results)
    results

    eval("class Human < SQLObject;end")
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class::columns.include?(attr_name)

      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= Hash.new
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

@sql_object = SQLObject
