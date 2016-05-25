function [] = plotsamples(samples, n);


figure();
for i=1:n
        sorted_sample = sortrows(samples(:,:,i),2);
        plot(sorted_sample(:,2),sorted_sample(:,3));
        hold on;
end
axis([0 1 0 1]);
hold off;

