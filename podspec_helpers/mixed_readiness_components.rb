module MixedReadinessComponents
  class MixedReadinessComponent
    attr_accessor :public_header_files
    attr_accessor :source_files
    attr_accessor :unit_test_source_files

    attr_accessor :beta_public_header_files
    attr_accessor :beta_source_files
    attr_accessor :beta_unit_test_source_files
    def initialize(
        public_header_files,
        source_files,
        unit_test_source_files,
        beta_public_header_files,
        beta_source_files,
        beta_unit_test_source_files)
      @public_header_files = public_header_files
      @source_files = source_files
      @unit_test_source_files = unit_test_source_files
      @beta_public_header_files = beta_public_header_files
      @beta_source_files = beta_source_files
      @beta_unit_test_source_files = beta_unit_test_source_files
    end

    def beta_source_and_header_files
      return beta_public_header_files + beta_source_files
    end
  end

  def self.text_fields
    beta_public_header_files = Dir.glob([
      "components/TextFields/src/MDCBaseTextField.h"
    ])

    beta_source_files = Dir.glob([
      "components/TextFields/src/MDCBaseTextField.{h,m}"
    ])

    beta_unit_test_source_files = Dir.glob([
      "components/TextFields/tests/unit/MDCBaseTextFieldTests.m"
    ])

    public_header_files = Dir.glob([
      "components/TextFields/src/*.h"
    ]) - beta_public_header_files

    source_files = Dir.glob([
      "components/TextFields/src/*.{h,m}",
      "components/TextFields/src/private/*.{h,m}"
    ]) - beta_source_files

    unit_test_source_files = Dir.glob([
      "components/TextFields/tests/unit/*.{h,m,swift}",
      "components/TextFields/tests/unit/MDCBaseTextFieldTests.m",
      "components/TextFields/tests/unit/supplemental/*.{h,m,swift}",
    ]) - beta_unit_test_source_files

    return MixedReadinessComponent.new(
      public_header_files,
      source_files,
      unit_test_source_files,
      beta_public_header_files,
      beta_source_files,
      beta_unit_test_source_files)
  end
end
