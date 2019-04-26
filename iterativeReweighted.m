
function [X,cost] = iterativeReweighted(mask,X,c,lambda,sigma,iter,n,N)

cost=[];

[~,L] = computeL(X,1,n,N,sigma);

for i = 1:iter
    
    gradX = @(x)(mask(:).*x + lambda*XL(x,L,n,N));
    
   [X,FLAG,RELRES,ITER,err] = pcg(gradX,c(:),10^-15,100,[],[],X(:));
        
    [d,L] = computeL(X,i+1,n,N,sigma);
    
    [cost1(i), cost2(i)] = IterativeReweightedComputeCost(X,mask,c,lambda,d,sigma,n,N);
    cost = cost1+cost2;
    
    if i>1
        if (abs(cost(end) - cost(end-1))/abs(cost(end)) < 1e-7) && (i>200)
            break;
        end
    end
end

X = reshape(X,n,N);
