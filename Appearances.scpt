FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
@author Thanh Pham
@URL www.asianefficiency.com
@lastmod 10 Jun 2012

Imagine you are capturing a lot of notes and you want to later review 
them in Omnifocus? Most of the time you will forget transferring the 
notes into your Omnifocus inbox. This script will help automate this process.

For every note that you want to review, all you have to do is 
tag it with "review" (without quotes) and this script will 
automatically make a new task in your Omnifocus inbox for review 
that links back to your Evernote note.

By default the format of the task is:

"Review: title of your Evernote note" (without the quotes)

Once the task is created, the script will delete the tag from 
the note in Evernote.

REQUIREMENTS:
* Evernote
* Omnifocus

Credit goes to Nick Wild of 360 Degree Media (www.360degreesmedia.com/) 
for the original script. All I have done is modified some bits and pieces, 
but all credit should go to Nick Wild.

If you want to have this script run automatically on a regular interval,
use the program Lingon. Read this blog post on how to do it:

http://www.asianefficiency.com/technology/transfer-evernote-to-omnifocus/

Have fun with the script. If you like it, please leave a comment
on the post mentioned above.

-Thanh Pham
www.asianefficiency.com
     � 	 		� 
 @ a u t h o r   T h a n h   P h a m 
 @ U R L   w w w . a s i a n e f f i c i e n c y . c o m 
 @ l a s t m o d   1 0   J u n   2 0 1 2 
 
 I m a g i n e   y o u   a r e   c a p t u r i n g   a   l o t   o f   n o t e s   a n d   y o u   w a n t   t o   l a t e r   r e v i e w   
 t h e m   i n   O m n i f o c u s ?   M o s t   o f   t h e   t i m e   y o u   w i l l   f o r g e t   t r a n s f e r r i n g   t h e   
 n o t e s   i n t o   y o u r   O m n i f o c u s   i n b o x .   T h i s   s c r i p t   w i l l   h e l p   a u t o m a t e   t h i s   p r o c e s s . 
 
 F o r   e v e r y   n o t e   t h a t   y o u   w a n t   t o   r e v i e w ,   a l l   y o u   h a v e   t o   d o   i s   
 t a g   i t   w i t h   " r e v i e w "   ( w i t h o u t   q u o t e s )   a n d   t h i s   s c r i p t   w i l l   
 a u t o m a t i c a l l y   m a k e   a   n e w   t a s k   i n   y o u r   O m n i f o c u s   i n b o x   f o r   r e v i e w   
 t h a t   l i n k s   b a c k   t o   y o u r   E v e r n o t e   n o t e . 
 
 B y   d e f a u l t   t h e   f o r m a t   o f   t h e   t a s k   i s : 
 
 " R e v i e w :   t i t l e   o f   y o u r   E v e r n o t e   n o t e "   ( w i t h o u t   t h e   q u o t e s ) 
 
 O n c e   t h e   t a s k   i s   c r e a t e d ,   t h e   s c r i p t   w i l l   d e l e t e   t h e   t a g   f r o m   
 t h e   n o t e   i n   E v e r n o t e . 
 
 R E Q U I R E M E N T S : 
 *   E v e r n o t e 
 *   O m n i f o c u s 
 
 C r e d i t   g o e s   t o   N i c k   W i l d   o f   3 6 0   D e g r e e   M e d i a   ( w w w . 3 6 0 d e g r e e s m e d i a . c o m / )   
 f o r   t h e   o r i g i n a l   s c r i p t .   A l l   I   h a v e   d o n e   i s   m o d i f i e d   s o m e   b i t s   a n d   p i e c e s ,   
 b u t   a l l   c r e d i t   s h o u l d   g o   t o   N i c k   W i l d . 
 
 I f   y o u   w a n t   t o   h a v e   t h i s   s c r i p t   r u n   a u t o m a t i c a l l y   o n   a   r e g u l a r   i n t e r v a l , 
 u s e   t h e   p r o g r a m   L i n g o n .   R e a d   t h i s   b l o g   p o s t   o n   h o w   t o   d o   i t : 
 
 h t t p : / / w w w . a s i a n e f f i c i e n c y . c o m / t e c h n o l o g y / t r a n s f e r - e v e r n o t e - t o - o m n i f o c u s / 
 
 H a v e   f u n   w i t h   t h e   s c r i p t .   I f   y o u   l i k e   i t ,   p l e a s e   l e a v e   a   c o m m e n t 
 o n   t h e   p o s t   m e n t i o n e d   a b o v e . 
 
 - T h a n h   P h a m 
 w w w . a s i a n e f f i c i e n c y . c o m 
   
  
 l     ��������  ��  ��        l     ��  ��    I C You can change the variables below to customize it to your liking.     �   �   Y o u   c a n   c h a n g e   t h e   v a r i a b l e s   b e l o w   t o   c u s t o m i z e   i t   t o   y o u r   l i k i n g .      l     ��������  ��  ��        l     ��  ��    % ########## CAN EDIT ###########     �   > # # # # # # # # # #   C A N   E D I T   # # # # # # # # # # #      l     ��  ��    7 1 this is the tag you use for flagging in Evernote     �   b   t h i s   i s   t h e   t a g   y o u   u s e   f o r   f l a g g i n g   i n   E v e r n o t e      l     ��   ��    ) # here I use review (case sensitive)      � ! ! F   h e r e   I   u s e   r e v i e w   ( c a s e   s e n s i t i v e )   " # " j     �� $�� 0 todotag todoTag $ m      % % � & &  r e v i e w #  ' ( ' l     ��������  ��  ��   (  ) * ) l     �� + ,��   + N H the name of the task starts by default with "Review: " (without quotes)    , � - - �   t h e   n a m e   o f   t h e   t a s k   s t a r t s   b y   d e f a u l t   w i t h   " R e v i e w :   "   ( w i t h o u t   q u o t e s ) *  . / . l     �� 0 1��   0 !  change this to your liking    1 � 2 2 6   c h a n g e   t h i s   t o   y o u r   l i k i n g /  3 4 3 j    �� 5�� 0 
taskprefix 
taskPrefix 5 m     6 6 � 7 7  R e v i e w :   4  8 9 8 l     ��������  ��  ��   9  : ; : j    �� <�� 0 notepath   < m     = = � > > ^ / L i b r a r y / C a c h e s / M e t a d a t a / c o m . e v e r n o t e . E v e r n o t e / ;  ? @ ? l     �� A B��   A % ########## CAN EDIT ###########    B � C C > # # # # # # # # # #   C A N   E D I T   # # # # # # # # # # # @  D E D l     ��������  ��  ��   E  F G F l     ��������  ��  ��   G  H I H l     �� J K��   J Y S Find home folder for use in finding Evernote files. Notepath is appended to this.     K � L L �   F i n d   h o m e   f o l d e r   f o r   u s e   i n   f i n d i n g   E v e r n o t e   f i l e s .   N o t e p a t h   i s   a p p e n d e d   t o   t h i s .   I  M N M l    	 O���� O r     	 P Q P n      R S R 1    ��
�� 
psxp S l     T���� T I    �� U��
�� .earsffdralis        afdr U m     ��
�� afdrcusr��  ��  ��   Q o      ���� 0 mypath myPath��  ��   N  V W V l  
  X���� X r   
  Y Z Y l  
  [���� [ I  
 �� \��
�� .sysolocSutxt        TEXT \ m   
  ] ] � ^ ^  C R E A T E D _ L A B E L��  ��  ��   Z o      ����  0 strnotecreated strNoteCreated��  ��   W  _ ` _ l    a���� a r     b c b l    d���� d I   �� e��
�� .sysolocSutxt        TEXT e m     f f � g g " T O D O S _ C R E A T E D _ O N E��  ��  ��   c o      ���� (0 strtodoscreatedone strTodosCreatedOne��  ��   `  h i h l   ! j���� j r    ! k l k l    m���� m I   �� n��
�� .sysolocSutxt        TEXT n m     o o � p p $ T O D O S _ C R E A T E D _ M A N Y��  ��  ��   l o      ���� *0 strtodoscreatedmany strTodosCreatedMany��  ��   i  q r q l     ��������  ��  ��   r  s t s l  " & u���� u r   " & v w v J   " $����   w o      ���� 0 thetodolist theTodoList��  ��   t  x y x l     ��������  ��  ��   y  z { z l  'H |���� | Q   'H } ~  } k   *1 � �  � � � l  * *��������  ��  ��   �  � � � O   */ � � � k   .. � �  � � � l   . .�� � ���   � � � set currentNote to selection	set currentNoteName to (title of item 1 of currentNote)	set currentID to (local id of item 1 of currentNote)     � � � �   s e t   c u r r e n t N o t e   t o   s e l e c t i o n  	 s e t   c u r r e n t N o t e N a m e   t o   ( t i t l e   o f   i t e m   1   o f   c u r r e n t N o t e )  	 s e t   c u r r e n t I D   t o   ( l o c a l   i d   o f   i t e m   1   o f   c u r r e n t N o t e )   �  � � � l  . .��������  ��  ��   �  � � � r   . 3 � � � n  . 1 � � � 1   / 1��
�� 
txdl � 1   . /��
�� 
ascr � o      ���� "0 saveddelimiters savedDelimiters �  � � � r   4 = � � � J   4 9 � �  ��� � m   4 7 � � � � �  /��   � n      � � � 1   : <��
�� 
txdl � 1   9 :��
�� 
ascr �  � � � l  > >��������  ��  ��   �  � � � l  > >�� � ���   � * $ find all notes tagged with todo tag    � � � � H   f i n d   a l l   n o t e s   t a g g e d   w i t h   t o d o   t a g �  � � � r   > O � � � I  > K�� ���
�� .EVRNfindnull���     ctxt � b   > G � � � m   > A � � � � �  t a g : � o   A F���� 0 todotag todoTag��   � o      ���� 0 
foundnotes 
foundNotes �  � � � l  P P��������  ��  ��   �  � � � X   P, ��� � � k   f' � �  � � � r   f o � � � l  f k ����� � l  f k ����� � n   f k � � � 1   g k��
�� 
EVet � o   f g���� 0 anote aNote��  ��  ��  ��   � o      ���� 0 entitle enTitle �  � � � r   p } � � � b   p y � � � o   p u���� 0 
taskprefix 
taskPrefix � o   u x���� 0 entitle enTitle � o      ���� 0 entitle enTitle �  � � � r   ~ � � � � l  ~ � ����� � l  ~ � ����� � n   ~ � � � � 2   ���
�� 
EVtg � o   ~ ���� 0 anote aNote��  ��  ��  ��   � o      ���� 0 entags enTags �  � � � l  � ��� � ���   � ) #set enId to (the local id of aNote)    � � � � F s e t   e n I d   t o   ( t h e   l o c a l   i d   o f   a N o t e ) �  � � � l  � ��� � ���   � 0 *set enFile to (the last text item of enId)    � � � � T s e t   e n F i l e   t o   ( t h e   l a s t   t e x t   i t e m   o f   e n I d ) �  � � � l  � ��� � ���   � = 7 set enLink to myPath & notepath & enFile & ".evernote"    � � � � n   s e t   e n L i n k   t o   m y P a t h   &   n o t e p a t h   &   e n F i l e   &   " . e v e r n o t e " �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
EV24 � o   � ����� 0 anote aNote � o      ���� 0 enlink enLink �  � � � r   � � � � � K   � � � � �� � ��� 0 thetitle theTitle � o   � ����� 0 entitle enTitle � �� � ��� 0 thelink   � o   � ����� 0 enlink enLink � �� ����� 0 thetags theTags � o   � ����� 0 entags enTags��   � n       � � �  ;   � � � o   � ��� 0 thetodolist theTodoList �  � � � l  � ��~�}�|�~  �}  �|   �  � � � r   � � � � � b   � � � � � o   � ��{�{ 0 
taskprefix 
taskPrefix � o   � ��z�z 0 entitle enTitle � o      �y�y 0 
ennotename   �  � � � r   � � � � � o   � ��x�x "0 saveddelimiters savedDelimiters � n      � � � 1   � ��w
�w 
txdl � 1   � ��v
�v 
ascr �  � � � l  � ��u�t�s�u  �t  �s   �  � � � Q   �% �  � k   �  l  � ��r�q�p�r  �q  �p    O   � k   �		 

 r   � � I  � ��o�n
�o .corecrel****      � null�n   �m
�m 
kocl m   � ��l
�l 
FCit �k�j
�k 
prdt K   � � �i
�i 
pnam l  � ��h�g o   � ��f�f 0 entitle enTitle�h  �g   �e�d
�e 
FCno m   � � �  �d  �j   o      �c�c 0 newtask    l  � ��b�a�`�b  �a  �`    O   � k   �
  !  l  � ��_"#�_  " B < make new file attachment with properties {file name:enLink}   # �$$ x   m a k e   n e w   f i l e   a t t a c h m e n t   w i t h   p r o p e r t i e s   { f i l e   n a m e : e n L i n k }! %&% r   �'(' o   � �^�^ 0 enlink enLink( n      )*) 1  �]
�] 
FCno* o   �\�\ 0 newtask  & +,+ l 		�[-.�[  - * $set note expanded of newtask to true   . �// H s e t   n o t e   e x p a n d e d   o f   n e w t a s k   t o   t r u e, 010 l 		�Z23�Z  2 
 open   3 �44  o p e n1 5�Y5 l 		�X�W�V�X  �W  �V  �Y   l  � �6�U�T6 n   � �787 1   � ��S
�S 
FCno8 o   � ��R�R 0 newtask  �U  �T   9�Q9 l �P�O�N�P  �O  �N  �Q   n   � �:;: 4  � ��M<
�M 
docu< m   � ��L�L ; m   � �==�                                                                                  OFOC  alis    X  Macintosh HD               ǸйH+  
αOmniFocus.app                                                  
������i        ����  	                Applications    Ǹ©      ���I    
α  (Macintosh HD:Applications: OmniFocus.app    O m n i F o c u s . a p p    M a c i n t o s h   H D  Applications/OmniFocus.app  / ��   >�K> l �J�I�H�J  �I  �H  �K    R      �G?�F
�G .ascrerr ****      � ****? o      �E�E 
0 errmsg  �F   I %�D@A
�D .sysodlogaskr        TEXT@ o  �C�C 
0 errmsg  A �BB�A
�B 
btnsB J  !CC D�@D m  EE �FF B O o p s .   D i d   y o u   c r e a t e   t h e   c o n t e x t ?�@  �A   � G�?G l &&�>�=�<�>  �=  �<  �?  �� 0 anote aNote � o   S V�;�; 0 
foundnotes 
foundNotes � HIH l --�:�9�8�:  �9  �8  I J�7J l --�6�5�4�6  �5  �4  �7   � m   * +KK�                                                                                  EVRN  alis    V  Macintosh HD               ǸйH+  
αEvernote.app                                                   �����        ����  	                Applications    Ǹ©      ����    
α  'Macintosh HD:Applications: Evernote.app     E v e r n o t e . a p p    M a c i n t o s h   H D  Applications/Evernote.app   / ��   � L�3L l 00�2�1�0�2  �1  �0  �3   ~ R      �/M�.
�/ .ascrerr ****      � ****M o      �-�- 
0 errmsg  �.    k  9HNN OPO I 9F�,QR
�, .sysodlogaskr        TEXTQ o  9:�+�+ 
0 errmsg  R �*S�)
�* 
btnsS J  =BTT U�(U m  =@VV �WW b O o p s .   C o u l d n ' t   f i n d   E v e r n o t e !   T r y   c h a n g i n g   p a t h s .�(  �)  P X�'X l GG�&�%�$�&  �%  �$  �'  ��  ��   { YZY l     �#�"�!�#  �"  �!  Z [\[ l     � ���   �  �  \ ]^] l     ����  �  �  ^ _`_ l Iha��a Q  Ihbcdb O  L_efe I P^�g�
� .coredelonull���     ****g 4  PZ�h
� 
EVtgh o  TY�� 0 todotag todoTag�  f m  LMii�                                                                                  EVRN  alis    V  Macintosh HD               ǸйH+  
αEvernote.app                                                   �����        ����  	                Applications    Ǹ©      ����    
α  'Macintosh HD:Applications: Evernote.app     E v e r n o t e . a p p    M a c i n t o s h   H D  Applications/Evernote.app   / ��  c R      �j�
� .ascrerr ****      � ****j o      �� 
0 errmsg  �  d l gg�kl�  k + %do nothing when it can't find the tag   l �mm J d o   n o t h i n g   w h e n   i t   c a n ' t   f i n d   t h e   t a g�  �  ` non l     ����  �  �  o p�p l     ���
�  �  �
  �       �	q % 6 =r�	  q ����� 0 todotag todoTag� 0 
taskprefix 
taskPrefix� 0 notepath  
� .aevtoappnull  �   � ****r �s��tu�
� .aevtoappnull  �   � ****s k    hvv  Mww  Vxx  _yy  hzz  s{{  z|| _� �   �  �  t ������ 0 anote aNote�� 
0 errmsg  u 3�������� ]���� f�� o����K������ � ���������������������������������=����������������������E��V��
�� afdrcusr
�� .earsffdralis        afdr
�� 
psxp�� 0 mypath myPath
�� .sysolocSutxt        TEXT��  0 strnotecreated strNoteCreated�� (0 strtodoscreatedone strTodosCreatedOne�� *0 strtodoscreatedmany strTodosCreatedMany�� 0 thetodolist theTodoList
�� 
ascr
�� 
txdl�� "0 saveddelimiters savedDelimiters
�� .EVRNfindnull���     ctxt�� 0 
foundnotes 
foundNotes
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
EVet�� 0 entitle enTitle
�� 
EVtg�� 0 entags enTags
�� 
EV24�� 0 enlink enLink�� 0 thetitle theTitle�� 0 thelink  �� 0 thetags theTags�� �� 0 
ennotename  
�� 
docu
�� 
FCit
�� 
prdt
�� 
pnam
�� 
FCno�� 
�� .corecrel****      � null�� 0 newtask  �� 
0 errmsg  ��  
�� 
btns
�� .sysodlogaskr        TEXT
�� .coredelonull���     ****�i�j �,E�O�j E�O�j E�O�j E�OjvE�O���,E�Oa kv��,FOa b   %j E` O �_ [a a l kh  �a ,E` Ob  _ %E` O�a -E` O�a ,E` Oa _ a _ a _ a  �6FOb  _ %E` !O���,FO Ra "a #k/ A*a a $a %a &_ a 'a (a )a ) *E` +O_ +a ', _ _ +a ',FOPUOPUOPW X , -�a .a /kvl 0OP[OY�9OPUOPW X , -�a .a 1kvl 0OPO � *a b   /j 2UW X , -h ascr  ��ޭ