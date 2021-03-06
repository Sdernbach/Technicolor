

% compute Geary's C index to compute spatial autocorrelation for movie
% recommendation dataset  for a particular latent factor 

function gc = geary_cindex(A,B,  factor,sigma) 

% A is an array of size N x f, where N is number of selected users
% number of columns f is number of latent factors 

% B is an array of size N x (user ID, zipcode, latitude, longitude) 

[N, c] = size(A); 

lf = c-2; % first two coordinates are latitude and longitude 

cnum = 0; % numerator term of Geary's C index
cdenom = 0; % denominator in Geary's C index 

w = zeros(N,N); % measures distance between two users based on geographical location 



Amu = mean(A(:,factor)); % compute mean of desired factor 

for i=1:N
    for j=1:N
        if i ~= j 
            w(i,j) = exp(-norm(B(i,3:4)-B(j,3:4))^2/sigma); % heat kernel 
        
            cnum = cnum + w(i,j)*(A(i,factor) - A(j,factor))^2; 
        end; 
        
        % cdenom = cdenom + w(i,j)*(A(i,factor) - Amu)^2; 
    end; 
end;

cdenom = 2*sum(sum(w,1))*var(A(:,factor)); 

gc = cnum/cdenom; 


        
     
        