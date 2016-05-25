
function [summarized_samples sample_counts] = deparse_data2(all_samples, num_symbols)

deparsed_samples = [];
summarized_samples = [];

for c=1:length(all_samples)
    %fprintf('configuration %d\n', c);
    samples = all_samples{c};
    for i=1:size(samples,1);
%        if (mod(i,100) == 0)
%            fprintf('sample %d\n',i);
%        end
        s = samples(i,:);
        switch c
            case 1
                [ul ur ll lr] = ...
                      ind2sub(size(zeros(num_symbols,num_symbols,num_symbols,num_symbols)), s(1));
            case 2
                [ur ll lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(2));
                [ul] = ind2sub(size(zeros(num_symbols)), s(1));
            case 3
                [ur] = ind2sub(size(zeros(num_symbols)), s(2));
                [ul ll lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(1));
            case 4
                [ul ur lr] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(1));
                [ll] = ind2sub(size(zeros(num_symbols)), s(2));
            case 5
                [ul ur ll] = ind2sub(size(zeros(num_symbols,num_symbols,num_symbols)), s(1));
                [lr] = ind2sub(size(zeros(num_symbols)), s(2));
            case 6
                [ul ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ur lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(2));
            case 7
                [ul ur] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ll lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(2));
            case 8
                [ul lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ur ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(2));
            case 9
                [ul ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ur] = ind2sub(size(zeros(num_symbols)), s(2));
                [lr] = ind2sub(size(zeros(num_symbols)), s(3));
            case 10
                [ur lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ul] = ind2sub(size(zeros(num_symbols)), s(2));
                [ll] = ind2sub(size(zeros(num_symbols)), s(3));
            case 11
                [ll lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ul] = ind2sub(size(zeros(num_symbols)), s(2));
                [ur] = ind2sub(size(zeros(num_symbols)), s(3));
            case 12
                [ul ur] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ll] = ind2sub(size(zeros(num_symbols)), s(2));
                [lr] = ind2sub(size(zeros(num_symbols)), s(3));
            case 13
                [ur ll] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ul] = ind2sub(size(zeros(num_symbols)), s(2));
                [lr] = ind2sub(size(zeros(num_symbols)), s(3));
            case 14
                [ul lr] = ind2sub(size(zeros(num_symbols,num_symbols)), s(1));
                [ur] = ind2sub(size(zeros(num_symbols)), s(2));
                [ll] = ind2sub(size(zeros(num_symbols)), s(3));
            case 15
                [ul] = ind2sub(size(zeros(num_symbols)), s(1));
                [ur] = ind2sub(size(zeros(num_symbols)), s(2));
                [ll] = ind2sub(size(zeros(num_symbols)), s(3));
                [lr] = ind2sub(size(zeros(num_symbols)), s(4));
        end
        deparsed_samples = [deparsed_samples; ul ur ll lr];
    end
end


[unique_samples a b] = unique(deparsed_samples, 'rows');
sample_counts = histc(b, 1:numel(a));
% Iterate through unique samples
for sample_index=1:numel(sample_counts)
    s = deparsed_samples(a(sample_index),:);
    summarized_samples = [summarized_samples; s];
end

  