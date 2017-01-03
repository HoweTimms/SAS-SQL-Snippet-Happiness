{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf770
{\fonttbl\f0\fmodern\fcharset0 CourierNewPSMT;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red14\green110\blue109;\red107\green0\blue109;
\red0\green0\blue255;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c0\c50196\c50196;\cssrgb\c50196\c0\c50196;
\cssrgb\c0\c0\c100000;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\sl300\partightenfactor0

\f0\fs26\fsmilli13333 \cf2 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 data _tmp_1(keep=string page _p:);\
\pard\pardeftab720\sl300\sa240\partightenfactor0
\cf2 length _S_0 $
\f1\b \cf3 \strokec3 32767 
\f0\b0 \cf2 \strokec2 string $
\f1\b \cf3 \strokec3 1000
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \

\f0\fs26\fsmilli13333 array _S_[&_rc_] $
\f1\b \cf3 \strokec3 32000
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \

\f0\fs26\fsmilli13333 retain _O_ 
\f1\b \cf3 \strokec3 0 
\f0\b0 \cf2 \strokec2 re page; 
\f1\fs24 \

\f0\fs26\fsmilli13333 if _N_=
\f1\b \cf3 \strokec3 1 
\f0\b0 \cf2 \strokec2 then re = prxparse(\cf4 \strokec4 "/&_t_3/i"\cf2 \strokec2 ); 
\f1\fs24 \

\f0\fs26\fsmilli13333 infile \cf4 \strokec4 "&datafile..pdf" \cf2 \strokec2 truncover lrecl=\cf5 \strokec5 %eval\cf2 \strokec2 (
\f1\b \cf3 \strokec3 32000
\f0\b0 \cf2 \strokec2 *&_rc_) end=eof; 
\f1\fs24 \
\pard\pardeftab720\sl300\partightenfactor0

\f0\fs26\fsmilli13333 \cf2 input (_S_1-_S_&_rc_) (\cf3 \strokec3 $char32000.\cf2 \strokec2 );\
\pard\pardeftab720\sl300\sa240\partightenfactor0
\cf2 _i_ =
\f1\b \cf3 \strokec3 1
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \

\f0\fs26\fsmilli13333 _p0_ = 
\f1\b \cf3 \strokec3 768
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \
\pard\pardeftab720\sl300\partightenfactor0

\f0\fs26\fsmilli13333 \cf2 substr(_S_0,_p0_) = _S_[_i_];\
\pard\pardeftab720\sl300\sa240\partightenfactor0
\cf2 _p1_ = 
\f1\b \cf3 \strokec3 1
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \

\f0\fs26\fsmilli13333 do until(_i_=&_rc_ & _p1_=
\f1\b \cf3 \strokec3 0
\f0\b0 \cf2 \strokec2 ); 
\f1\fs24 \

\f0\fs26\fsmilli13333 if _i_<&_rc_ & (_p0_>
\f1\b \cf3 \strokec3 32000 
\f0\b0 \cf2 \strokec2 | _p1_=
\f1\b \cf3 \strokec3 0
\f0\b0 \cf2 \strokec2 ) then do; 
\f1\fs24 \

\f0\fs26\fsmilli13333 _i_ + 
\f1\b \cf3 \strokec3 1
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \

\f0\fs26\fsmilli13333 _p0_ = ifn(_p0_>
\f1\b \cf3 \strokec3 32000
\f0\b0 \cf2 \strokec2 ,_p0_-
\f1\b \cf3 \strokec3 32000
\f0\b0 \cf2 \strokec2 ,
\f1\b \cf3 \strokec3 1
\f0\b0 \cf2 \strokec2 ); 
\f1\fs24 \

\f0\fs26\fsmilli13333 substr(_S_0,_p0_) = substr(_S_0,_p0_+
\f1\b \cf3 \strokec3 32000
\f0\b0 \cf2 \strokec2 )||_S_[_i_]; 
\f1\fs24 \

\f0\fs26\fsmilli13333 end; 
\f1\fs24 \
\pard\pardeftab720\sl300\partightenfactor0

\f0\fs26\fsmilli13333 \cf2 _p1_ = find(_S_0,\cf4 \strokec4 ')Tj ET'\cf2 \strokec2 ,\cf4 \strokec4 'i'\cf2 \strokec2 ,_p0_);\
\pard\pardeftab720\sl300\sa240\partightenfactor0
\cf2 if _p1_=
\f1\b \cf3 \strokec3 0 
\f0\b0 \cf2 \strokec2 then continue; 
\f1\fs24 \

\f0\fs26\fsmilli13333 call prxnext(re,_p0_,_p1_+
\f1\b \cf3 \strokec3 5
\f0\b0 \cf2 \strokec2 ,_S_0,_p1_,_L1_); 
\f1\fs24 \

\f0\fs26\fsmilli13333 if _p1_=
\f1\b \cf3 \strokec3 0 
\f0\b0 \cf2 \strokec2 then continue; 
\f1\fs24 \

\f0\fs26\fsmilli13333 if _N_>_O_ then page + 
\f1\b \cf3 \strokec3 1
\f0\b0 \cf2 \strokec2 ; 
\f1\fs24 \
\pard\pardeftab720\sl300\partightenfactor0

\f0\fs26\fsmilli13333 \cf2 string = substr(_S_0,_p1_,_L1_);\
\pard\pardeftab720\sl300\sa240\partightenfactor0
\cf2 output; 
\f1\fs24 \

\f0\fs26\fsmilli13333 _O_ = _N_; 
\f1\fs24 \

\f0\fs26\fsmilli13333 end; 
\f1\fs24 \
\pard\pardeftab720\sl300\partightenfactor0

\f0\fs26\fsmilli13333 \cf2 if eof then call symputx(\cf4 \strokec4 '_O_'\cf2 \strokec2 ,_O_,\cf4 \strokec4 'L'\cf2 \strokec2 );\
\pard\pardeftab720\sl300\sa240\partightenfactor0
\cf2 run; 
\f1\fs24 \
}