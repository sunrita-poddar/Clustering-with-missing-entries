
function [cost1, cost2] = IterativeReweightedComputeCost(X,mask,c,lambda,d,sig,n,N)

X = reshape(X,n,N);

cost1 = gather(sum((mask(:).*X(:)-c(:)).^2)/2);

cost2 = gather(lambda*sum(1-exp(-d(:)/sig^2)));
