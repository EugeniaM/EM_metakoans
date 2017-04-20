def attribute (arg, &block)
	inst_var = arg
	if arg.class == Hash
		inst_var = arg.keys[0]
	end

	self.send :define_method, "#{inst_var}?" do
		!!self.instance_variable_get("@#{inst_var}".to_sym)
	end

	self.send :define_method, "#{inst_var}" do
		if !self.instance_variable_defined?("@#{inst_var}".to_sym)
			value = block ? (instance_eval &block) : (arg.is_a?(Hash) ? arg.values[0] : nil)
			self.instance_variable_set("@#{inst_var}".to_sym, value)
		end
		self.instance_variable_get("@#{inst_var}".to_sym)
	end

	self.send :define_method, "#{inst_var}=" do |arg|
		self.instance_variable_set("@#{inst_var}".to_sym, arg)
	end
end