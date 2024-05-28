function loadCheck = LoadCheck(group)
    for i = 1:48
        if group(i) > 13.2
            loadCheck = true;
        end
    end
    loadCheck = false;
end