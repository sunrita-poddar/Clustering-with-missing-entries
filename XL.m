
function res = XL(X,L,n,N)

X = reshape(X,n,N);

res = X*L;

res = res(:);