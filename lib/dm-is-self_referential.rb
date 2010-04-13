module DataMapper
  module Is

    module SelfReferential

      def is_self_referential(options = {})
        # Given 'Nested::Module::ClassName'
        # deepest_context = Nested::Module::
        # self_model_name = ClassName
        # ---
        # Given 'ClassName'
        # deepest_context = "::"
        # self_model_name = ClassName
        deepest_context, self_model_name = (self.name =~ /^(.*::)(.*)$/) ? [$1, $2] : ["::", self.name]
        sane_self_model_name = self.name.gsub(/::/, "").snake_case

        options = {
          :through     => "#{deepest_context}#{self_model_name}To#{self_model_name}",
          :children    => :children,
          :parents     => :parents,
          :source      => :source,
          :target      => :target
        }.merge!(options)

        Object.full_const_set(options[:through], Class.new)

        source_model       = self
        intermediate_model = Object.full_const_get(options[:through])
        target_model       = self

        source_fk = Extlib::Inflection.foreign_key(options[:source]).to_sym
        target_fk = Extlib::Inflection.foreign_key(options[:target]).to_sym

        intermediate_model.class_eval do
          include DataMapper::Resource
          property source_fk, Integer, :key => true
          property target_fk, Integer, :key => true
          belongs_to options[:source], source_model
          belongs_to options[:target], target_model
        end

        intermediate_children = "#{sane_self_model_name}_#{options[:children]}".to_sym
        intermediate_parents  = "#{sane_self_model_name}_#{options[:parents ]}".to_sym

        has n, intermediate_children, intermediate_model, :child_key => [ source_fk ]
        has n, intermediate_parents,  intermediate_model, :child_key => [ target_fk ]

        has n, options[:children], self, :through => intermediate_children, :via => :target
        has n, options[:parents ], self, :through => intermediate_parents,  :via => :source

      end

    end

  end
  Model.append_extensions(Is::SelfReferential)
end
