b=5;
a=-5;
N=32768;
c=10
T=(b-a)/N;
f=1/T;
A=2;
X0=ones(1,N)*c;
 
X1=zeros(1,N);
X2=zeros(1,N);
X3=zeros(1,N);
X3((N/2),1)=1;
X4=zeros(1,N);
X5=zeros(1,N);
X6=zeros(1,N);
for n=1:1:N
    P=(n-1)*T+a
    X1(n,1)=cos(2*pi*f*P);
    X2(n,1)=sin(2*pi*f*P);
    X4(n,1)=exp(1i*2*pi*f*P);
    if (P>-0.05 && P<0.05)
        X5(n,1)=1;
    end 
    X6(n,1)=exp(-pi*P^2);
end
