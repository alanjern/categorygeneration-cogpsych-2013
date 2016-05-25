% Search through a cell array and return 1 if item is found, 0 otherwise
function r = is_in(x, c)

r = 0;
for i=1:length(c)
    if (c{i} == x)
        r = 1;
        break;
    end
end

