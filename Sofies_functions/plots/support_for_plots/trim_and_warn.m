function trimmed_var = trim_and_warn(variable, target_length, var_name)
    if length(variable) > target_length
        disp(['Warning: Trimming ', var_name, ' from ', num2str(length(variable)), ' to ', num2str(target_length)]);
        trimmed_var = variable(1:target_length);
    else
        trimmed_var = variable;
    end
end