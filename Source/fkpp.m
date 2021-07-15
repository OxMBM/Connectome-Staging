function dy = fkpp(t,y,beta,L,n)

dy = zeros(n,1);
dy(1:n) = y(1:n).*(1-y(1:n)) + beta*L*y(1:n);
end