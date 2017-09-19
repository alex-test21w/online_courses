# NOTE: $ref is not validated with the schema: https://github.com/ruby-json-schema/json-schema/issues/309
# Until the problem is fixed, don't use this to validate arrays of nested items
RSpec::Matchers.define :match_schema do |schema|
  match do |json|
    schema_directory = "#{ Dir.pwd }/spec/schemas"
    schema_path = "#{ schema_directory }/#{ schema }.json"
    JSON::Validator.validate!(schema_path, json, strict: true, validate_schema: true)
  end
end
