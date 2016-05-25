% Function takes inputs:
%     - raw_data: a cell array of n x m matrices where n x m is the size
%           of the stimulus grid.
%     - pattern: the integer of the pattern to parse the data wrt.
%
% Returns a cell array (size f) of vectors (length k^(m_i)) of feature
% counts, where f is the number of feature dimensions, k is the number
% of symbols and m_i is the size of piece i.

function counts = parse_data(raw_data, pattern, num_symbols)

n = length(raw_data);

if (pattern == 1)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+   
    count1 = zeros(num_symbols, num_symbols, num_symbols, num_symbols);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(1,2), example(2,1), example(2,2)) = ...
            count1(example(1,1), example(1,2), example(2,1), example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^4,1)};
elseif (pattern == 2)
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,2), example(2,1), example(2,2)) = ...
            count1(example(1,2), example(2,1), example(2,2)) + 1;
        count2(example(1,1)) = ...
            count2(example(1,1)) + 1;
    end
    counts = {reshape(count1,num_symbols^3,1) reshape(count2,num_symbols,1)};
    
elseif (pattern == 3)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(2,1), example(2,2)) = ...
            count1(example(1,1), example(2,1), example(2,2)) + 1;
        count2(example(1,2)) = ...
            count2(example(1,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^3,1) reshape(count2,num_symbols,1)};
    
elseif (pattern == 4)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(1,2), example(2,2)) = ...
            count1(example(1,1), example(1,2), example(2,2)) + 1;
        count2(example(2,1)) = ...
            count2(example(2,1)) + 1;
    end
    counts = {reshape(count1,num_symbols^3,1) reshape(count2,num_symbols,1)};
    
elseif (pattern == 5)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(1,2), example(2,1)) = ...
            count1(example(1,1), example(1,2), example(2,1)) + 1;
        count2(example(2,2)) = ...
            count2(example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^3,1) reshape(count2,num_symbols,1)};
    
elseif (pattern == 6)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols, num_symbols);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(2,1)) = ...
            count1(example(1,1), example(2,1)) + 1;
        count2(example(1,2), example(2,2)) = ...
            count2(example(1,2), example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols^2,1)};
    
elseif (pattern == 7)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 2 | 2 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols, num_symbols);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(1,2)) = ...
            count1(example(1,1), example(1,2)) + 1;
        count2(example(2,1), example(2,2)) = ...
            count2(example(2,1), example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols^2,1)};
    
elseif (pattern == 8)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols, num_symbols);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(2,2)) = ...
            count1(example(1,1), example(2,2)) + 1;
        count2(example(1,2), example(2,1)) = ...
            count2(example(1,2), example(2,1)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols^2,1)};
    
elseif (pattern == 9)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 1 | 3 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(2,1)) = ...
            count1(example(1,1), example(2,1)) + 1;
        count2(example(1,2)) = ...
            count2(example(1,2)) + 1;
        count3(example(2,2)) = ...
            count3(example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1)};
    
elseif (pattern == 10)
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+        
%    | 3 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,2), example(2,2)) = ...
            count1(example(1,2), example(2,2)) + 1;
        count2(example(1,1)) = ...
            count2(example(1,1)) + 1;
        count3(example(2,1)) = ...
            count3(example(2,1)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1)};
    
elseif (pattern == 11)
%    +---+---+        
%    | 2 | 3 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(2,1), example(2,2)) = ...
            count1(example(2,1), example(2,2)) + 1;
        count2(example(1,1)) = ...
            count2(example(1,1)) + 1;
        count3(example(1,2)) = ...
            count3(example(1,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1)};
    
elseif (pattern == 12)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 2 | 3 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(1,2)) = ...
            count1(example(1,1), example(1,2)) + 1;
        count2(example(2,1)) = ...
            count2(example(2,1)) + 1;
        count3(example(2,2)) = ...
            count3(example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1)};
    
elseif (pattern == 13)
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+        
%    | 1 | 3 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,2), example(2,1)) = ...
            count1(example(1,2), example(2,1)) + 1;
        count2(example(1,1)) = ...
            count2(example(1,1)) + 1;
        count3(example(2,2)) = ...
            count3(example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1)};
    
elseif (pattern == 14)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 3 | 1 |        
%    +---+---+ 
    count1 = zeros(num_symbols, num_symbols);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1), example(2,2)) = ...
            count1(example(1,1), example(2,2)) + 1;
        count2(example(1,2)) = ...
            count2(example(1,2)) + 1;
        count3(example(2,1)) = ...
            count3(example(2,1)) + 1;
    end
    counts = {reshape(count1,num_symbols^2,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1)};
    
elseif (pattern == 15)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 3 | 4 |        
%    +---+---+ 
    count1 = zeros(num_symbols,1);
    count2 = zeros(num_symbols,1);
    count3 = zeros(num_symbols,1);
    count4 = zeros(num_symbols,1);
    for i=1:n
        example = raw_data{i};
        count1(example(1,1)) = ...
            count1(example(1,1)) + 1;
        count2(example(1,2)) = ...
            count2(example(1,2)) + 1;
        count3(example(2,1)) = ...
            count3(example(2,1)) + 1;
        count4(example(2,2)) = ...
            count4(example(2,2)) + 1;
    end
    counts = {reshape(count1,num_symbols,1) reshape(count2,num_symbols,1) ...
              reshape(count3,num_symbols,1) reshape(count4,num_symbols,1)};
end