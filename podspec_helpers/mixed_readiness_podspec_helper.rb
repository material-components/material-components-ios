# mixed readiness component podspec helper
module MixedReadinessPodspecHelper
  class MixedReadinessComponent
    attr_accessor :beta_public_header_files
    attr_accessor :beta_source_files
    attr_accessor :beta_unit_test_source_files
    def initialize(beta_public_header_files, beta_source_files, beta_unit_test_source_files)
      @beta_public_header_files = beta_public_header_files
      @beta_source_files = beta_source_files
      @beta_unit_test_source_files = beta_unit_test_source_files
    end

    def beta_source_and_header_files
      return beta_public_header_files + beta_source_files
    end
  end

  def self.mixed_readiness_component(component)
    case component
    when "TextFields"
      return text_fields
    else
      return []
    end
  end

  private
  def self.text_fields
    beta_header_files = ["components/TextFields/src/MDCBaseTextField.h"]
    beta_source_files = ["components/TextFields/src/MDCBaseTextField.{h,m}"]
    beta_unit_test_source_files = ["components/TextFields/tests/unit/MDCBaseTextFieldTests.m"]
    return MixedReadinessComponent.new(beta_header_files,beta_source_files, beta_unit_test_source_files)
  end
end
