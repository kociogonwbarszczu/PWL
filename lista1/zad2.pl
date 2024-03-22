on(block1, block2). /* block1 leży na block2*/
on(block2, block3).
on(block3, block4).

above(Block1, Block2) :-
    on(Block1, Block2);
    on(Block1, BlockX),
    above(BlockX, Block2).