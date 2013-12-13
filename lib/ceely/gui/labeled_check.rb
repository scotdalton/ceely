module Ceely
  module Gui
    class LabeledCheck
      extend Forwardable
      include ShoeElement
      attr_reader :label, :checkbox
      def_delegators :@checkbox, :checked?, :checked=

      def initialize(shoes, label, opts={})
        super(shoes, opts)
        @label = label
        checkflow = shoes.flow(width: 20) { shoes.check }
        shoes.flow(width: 350, attach: checkflow) { shoes.para(label) }
        @checkbox = checkflow.contents.first
      end
    end
  end
end
