function goal = goalfinder(posn)
global course;
N = size(course,1);
M = size(course,2);
bwcourse = zeros(N,M);
for i = 1:N
    for j = 1:M
        if course(i,j) == 76 %course(i,j)>74 && course(i,j)<77
            bwcourse(i,j) = 1;
        end
    end
end
% bwcourse1 = ~im2bw(course,77/255);
% bwcourse2 = im2bw(course,74/255);
bwcourse = bwareaopen(bwcourse,50);
s = regionprops(bwcourse,'centroid');
goal_unsort = round(cat(1, s.Centroid));
a = ones(size(goal_unsort,1),1).*posn(1);
b = ones(size(goal_unsort,1),1).* posn(2);
posn_n = cat(2,a,b);
dist_goal = sqrt(sum((goal_unsort-posn_n).^2,2));
[~,I] = sort(dist_goal);
goal = goal_unsort(I,:);