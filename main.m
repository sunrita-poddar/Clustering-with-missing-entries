
warning off 

load('data.mat');

n = size(data,1);
N = size(data,2);

lambda = [1e-10 1e-4 1e-3 1e-1 0.02:0.01:0.09 1e10];

p0 = 0.7;
sig = 0.06;
iter = 500;

tmp = rand(n,N);
mask = tmp<=p0;

c = mask.*data;
ini = c;

for i=1:length(lambda)
    [x,cost] = iterativeReweighted(mask,ini,c,lambda(i),sig,iter,n,N);
    X(:,:,i) = x;
    ini = X(:,:,i);
    close all
end

for i=1:length(lambda)
    [~, score] = pca(X(:,:,i)');
    score_all(:,:,i) = score;
end

for i=2:length(lambda)
    if squeeze(score_all(:,1,i))'*squeeze(score_all(:,1,1)) < 0
        score_all(:,1,i) = -score_all(:,1,i);
    end
    if squeeze(score_all(:,2,i))'*squeeze(score_all(:,2,1)) < 0
        score_all(:,2,i) = -score_all(:,2,i);
    end
end

figure;

for i=1:N/3
    plot(squeeze(score_all(i,1,:)), squeeze(score_all(i,2,:)), 'b');
    hold on
end

for i=N/3+1:2*N/3
    plot(squeeze(score_all(i,1,:)), squeeze(score_all(i,2,:)), 'r');
    hold on
end

for i=2*N/3+1:N
    plot(squeeze(score_all(i,1,:)), squeeze(score_all(i,2,:)), 'g');
    hold on
end

axis([-1.5 1.5 -1.5 1.5]);
