
function [d,L] = computeL(X,iter,n,N,sigma)
if iter>1
    X = reshape(X,n,N);
    X2 = sum(X.*conj(X),1);
    X3 = (X')*X;
    d = abs(repmat(X2,N,1)+repmat(X2',1,N)-2*real(X3))/n;
else
    for i=1:N
        for j=1:N
            m = and(X(:,i),X(:,j));
            l(i,j) = length(find(m));
            d(i,j) = sum(((X(:,i)-X(:,j)).*m).^2)/l(i,j);
        end
    end
    d(isnan(d)) = inf;
    d(l<4) = inf;
end

W = exp(-d./(sigma.^2))./(sigma.^2);

L = diag(sum(W,1)) - W;
