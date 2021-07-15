function dy = fkppxdam(t,y,delta,beta,L,n)

dy = zeros(n,1);
dy(1:n) = y(1:n).*(1-y(1:n)) + beta*L*y(1:n);
dy(n+1:2*n) = delta*y(1:n).*(1-y(n+1:2*n));
end