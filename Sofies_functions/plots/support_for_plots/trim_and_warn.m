function trimmed_var = trim_and_warn(variable, target_length, var_name)
    if size(variable, 2) > target_length
        disp(['Warning: Trimming ', var_name, ' from ', num2str(size(variable, 2)), ' to ', num2str(target_length)]);
        trimmed_var = variable(:, 1:target_length);
    else
        trimmed_var = variable;
    end
end
