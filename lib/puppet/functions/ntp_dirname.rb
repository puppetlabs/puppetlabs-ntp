Puppet::Functions.create_function(:ntp_dirname, Puppet::Functions::InternalFunction) do
  dispatch :ntp_dirname do
    scope_param
    optional_repeated_param 'Any', :args
  end
  def ntp_dirname(scope, *args)
    call_function('deprecation', 'ntp_dirname_removal', "ntp_dirname(): this function is deprecated and will be removed at a later time.")
    scope.send("function_ntp_dirname", args)
  end
end
