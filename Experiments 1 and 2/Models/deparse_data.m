
function [deparsed_samples sample_counts] = deparse_data(samples, pattern, num_symbols)

[n f] = size(samples);

if (pattern == 1)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+   
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ur ll lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols,num_symbols)), s(1));
        deparsed_samples{sample_index} = [ul ur; ll lr];
    end
    
elseif (pattern == 2)
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ur ll lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(2));
        [ul] = ind2sub(size(zeros(num_symbols)), s(1));
        deparsed_samples{sample_index} = [ul ur; ll lr];
    end

elseif (pattern == 3)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ur] = ind2sub(size(zeros(num_symbols)), s(2));
        [ul ll lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(1));
        deparsed_samples{sample_index} = [ul ur; ll lr];
    end
    
elseif (pattern == 4)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ur lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(1));
        [ll] = ind2sub(size(zeros(num_symbols)), s(2));
        deparsed_samples{sample_index} = [ul ur; ll lr];
    end
    
elseif (pattern == 5)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ur ll] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(1));
        [lr] = ind2sub(size(zeros(num_symbols)), s(2));
        deparsed_samples{sample_index} = [ul ur; ll lr];
    end
    
elseif (pattern == 6)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ur lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(2));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 7)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 2 | 2 |        
%    +---+---+ 

    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ur] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ll lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(2));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end

        
    
elseif (pattern == 8)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ur ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(2));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 9)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 1 | 3 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ur] = ind2sub(size(zeros(num_symbols)), s(2));
        [lr] = ind2sub(size(zeros(num_symbols)), s(3));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 10)
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+        
%    | 3 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ur lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ul] = ind2sub(size(zeros(num_symbols)), s(2));
        [ll] = ind2sub(size(zeros(num_symbols)), s(3));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 11)
%    +---+---+        
%    | 2 | 3 |        
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ll lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ul] = ind2sub(size(zeros(num_symbols)), s(2));
        [ur] = ind2sub(size(zeros(num_symbols)), s(3));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 12)
%    +---+---+        
%    | 1 | 1 |        
%    +---+---+        
%    | 2 | 3 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul ur] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ll] = ind2sub(size(zeros(num_symbols)), s(2));
        [lr] = ind2sub(size(zeros(num_symbols)), s(3));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 13)
%    +---+---+        
%    | 2 | 1 |        
%    +---+---+        
%    | 1 | 3 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ur ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ul] = ind2sub(size(zeros(num_symbols)), s(2));
        [lr] = ind2sub(size(zeros(num_symbols)), s(3));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 14)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 3 | 1 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
        [ur] = ind2sub(size(zeros(num_symbols)), s(2));
        [ll] = ind2sub(size(zeros(num_symbols)), s(3));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
    
elseif (pattern == 15)
%    +---+---+        
%    | 1 | 2 |        
%    +---+---+        
%    | 3 | 4 |        
%    +---+---+ 
    % Eliminate duplicates
    [unique_rows a b] = unique(samples, 'rows');
    % Get counts
    sample_counts = histc(b, 1:numel(a));
    deparsed_samples = cell(numel(a),1);
    % Iterate through unique samples
    for sample_index=1:numel(sample_counts)
        s = samples(a(sample_index),:);
        [ul] = ind2sub(size(zeros(num_symbols)), s(1));
        [ur] = ind2sub(size(zeros(num_symbols)), s(2));
        [ll] = ind2sub(size(zeros(num_symbols)), s(3));
        [lr] = ind2sub(size(zeros(num_symbols)), s(4));
        deparsed_samples{sample_index} = [ul ur; ll lr];
        %fprintf('x %d\n', sample_counts(sample_index));
    end
end
