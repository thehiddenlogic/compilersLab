# compilerlab

* **supported OS:** ubuntu 16.0.4, 14.0.4

* how to run commands and inputs are given in separate txt files in each folder.

* **3add_bb_cfg:** 
  * Generates 3 address statement for the given inputs 
  * Constructs basic blocks from the 3 address intructions
  * Forms control flow of the basic blocks 

* **Backpatching:**
  * Creates 3 address statement with backpatching of addresses 
  
* **copy_constant:** 
  * Generates 3 address statements after optimisation ( copy propagation , constant assignment )

* **dag:**
  * Constructs Directed Acyclic Graph for each basic block in the given set of C statements 
  
* **dangling_else:** 
  * Adds else with an empty block for each unmatched if ( throws error )

* **for_dowhile:**
  * Converts for and do-while loops into while loops ( throws error )
  
* **label_trees:** 
  * Generates machine code for the given expressions 

* **symbol_table:**
  * Generates symbol table for the given C statements
  
* **syntax_tree:**
  * Validates arithmetic expressions  

