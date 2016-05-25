clear all;
close all;
datapath = './';

w = what(datapath);
files = w.mat;

allsubjects = figure;
for c=1:3
    subplot(2,2,c);
    hold on;
    xlabel('Length');
    ylabel('Saturation');
    axis([0.05, 0.8, 0, 1]);
end

allsubjectshue = figure;
for c=1:3
    subplot(2,2,c);
    hold on;
    xlabel('Length');
    ylabel('Hue');
    axis([0.05, 0.8, 0, 1]);
end

correlationhistogram = figure;
for c=1:3
    subplot(2,2,c);
end

% Matrix of subject numbers
subnums = zeros(length(files),1);
% Matrix of correlation coefficients
rcoefs = zeros(length(files),3);
% Matrix of hue stdevs
% The prediction is that the mean stdev should be around 0
% in all cases, indicating that people learned that hue is
% invariant within a crystal type
huestdevs = zeros(length(files),3);

% Explanation file
explainfile = fopen('explain.txt', 'w');

for f=1:length(files)
    load(strcat(datapath,files{f}));
    for p=1:1
        cdata{p}{1} = userps.newcrystaldata{p}{1};
        cdata{p}{2} = userps.newcrystaldata{p}{2};
        cdata{p}{3} = userps.newcrystaldata{p}{3};
    end
    if (userps.trainingspace == 0)
        ax = [(0.8-0.05)/2 + 0.05, 0.8, (1-0.05)/2 + 0.05, 1, 0, 1];
    else
        ax = [0.05, (0.8-0.05)/2 + 0.05, 0.05, (1-0.05)/2 + 0.05, 0, 1];
    end
    ax3 = [0.05, 0.8, 0.05, 1, 0, 1];
    ax2 = [0.05, 0.8, 0, 1];
    
    subjectdata = regexp(files{f},'_','split');
    subnum = subjectdata{2};
    subcond = subjectdata{1}(5);
    condorders = {'[3 2 1]', '[3 1 2]', '[2 3 1]',
                  '[2 1 3]', '[1 2 3]', '[1 3 2]'};
    subcondorder = condorders{str2num(subcond)};
    
    
    for p=1:1
        for c=1:2
            for e=1:4
                lengths(p,1,c,e) = guips.crystal.len{1}{c}{e};
                lengths(p,2,c,e) = guips.crystal.len{2}{c}{e};
                lengths(p,3,c,e) = guips.crystal.len{3}{c}{e};
    
                ccolor1 = guips.crystal.color{1}{c}{e};
                ccolor2 = guips.crystal.color{2}{c}{e};
                ccolor3 = guips.crystal.color{3}{c}{e};
        
                % flip values if using high end of scale
                if (p == 1)
                    ccolor1(2) = ccolor1(2) * 2 - 0.05;
                    ccolor2(2) = ccolor2(2) * 2 - 0.05;
                    ccolor3(2) = ccolor3(2) * 2 - 0.05;
                    lengths(p,1,c,e) = guips.crystal.len{1}{c}{e} * 2 - 0.05;
                    lengths(p,2,c,e) = guips.crystal.len{2}{c}{e} * 2 - 0.05;
                    lengths(p,3,c,e) = guips.crystal.len{3}{c}{e} * 2 - 0.05;
                else
                    if (userps.trainingspace == 1)
                        ccolor1(2) = 1 - ccolor1(2);
                        ccolor2(2) = 1 - ccolor2(2);
                        ccolor3(2) = 1 - ccolor3(2);
                        lengths(p,1,c,e) = 0.8 - guips.crystal.len{1}{c}{e};
                        lengths(p,2,c,e) = 0.8 - guips.crystal.len{2}{c}{e};
                        lengths(p,3,c,e) = 0.8 - guips.crystal.len{3}{c}{e};
                    end
                end

                   
                colors(p,1,c,e) = ccolor1(2);
                colors(p,2,c,e) = ccolor2(2);
                colors(p,3,c,e) = ccolor3(2); 
                
                hues(p,1,c) = guips.crystal.basehue{userps.catcolors(1,userps.cats{1}(c))};
                hues(p,2,c) = guips.crystal.basehue{userps.catcolors(2,userps.cats{2}(c))};
                hues(p,3,c) = guips.crystal.basehue{userps.catcolors(3,userps.cats{3}(c))};
            end

        end
    end
    


    % Write out the explanations
    fprintf(explainfile, '=== Subject %s ===\n', subjectdata{2}); 
    for p=1:1
        fprintf(explainfile, 'Phase %d\n', p);
        for c=1:3
            fprintf(explainfile, '    Condition %d\n', c);
            for i=1:2
                expl = userps.explanations{p}{c}{i};
                if (i == 1)
                    fprintf(explainfile, '        Describe:\n');
                else
                    fprintf(explainfile, '        Explain:\n');
                end
                for (l = 1:size(expl,1))
                    fprintf(explainfile, '            %s\n', expl(l,:));
                end    
                explanations{f}{p}{c}{i} = expl;
            end
        end
    end
    fprintf(explainfile, '\n');
    
    subnums(f) = str2num(subnum);
    
    for c=1:3
        r_f = corrcoef(cdata{1}{c}(3:8,1), cdata{1}{c}(3:8,2));
        rcoefs(f,c) = r_f(1,2);
        huestdevs(f,c) = std(cdata{1}{c}(3:8,3));
        
        figure(allsubjects);
        subplot(2,2,c);
        subjectdata = sortrows([cdata{1}{c}(3:8,1), cdata{1}{c}(3:8,2)],1);
        plot(subjectdata(:,1), subjectdata(:,2));
        
        figure(allsubjectshue);
        subplot(2,2,c);
        subjectdata = sortrows([cdata{1}{c}(3:8,1), cdata{1}{c}(3:8,3)],1);
        plot(subjectdata(:,1), subjectdata(:,2));

    end
end

fclose(explainfile);

% Compute average correlation coefficients

for c=1:3
    figure(allsubjects);
    subplot(2,2,c);
    t = sprintf('Condition %d, Mean r = %.3f', c, mean(rcoefs(:,c)));
    title(t);
    hold off;
    figure(allsubjectshue);
    subplot(2,2,c);
    t = sprintf('Condition %d', c);
    title(t);
    hold off;

    figure(correlationhistogram);
    subplot(2,2,c);
    hist(rcoefs(:,c));
    hold on;
    t = sprintf('Condition %d', c);
    title(t);
    hold off;
    
    
    fprintf('Condition %d mean r: %f, std: %f\n', c, mean(rcoefs(:,c)), std(rcoefs(:,c)));
    fprintf('Condition %d mean hue stdev: %f\n', c, mean(huestdevs(:,c)));
end

