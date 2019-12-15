require_relative 'abstract_service'

class AbstractReader < AbstractService
  def initialize(resource_path)
    @resource_path = resource_path
  end
end