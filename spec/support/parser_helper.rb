# frozen_string_literal: true

require 'prism_ext'

module ParserHelper
  def prism_parse(code)
    Prism.parse(code).value.statements
  end
end
