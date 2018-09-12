ENTRY
  { 
    abstract
    address
    author
    editor
    howpublished
    publisher
    title
    url
    volume
    year
  }
  {}
  { label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
STRINGS { s t}
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block = 
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}
FUNCTION {output.nonnull.nostate}
{ 's :=
  output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    'write$
  if$
  s
}
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}
FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}
INTEGERS { nameptr namesleft numnames posothers showetal}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
           swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}
FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}
FUNCTION {add.colon}
{ duplicate$ empty$
    'skip$
    { ":" * add.blank }
  if$
}
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}
FUNCTION {italize}
{ duplicate$ empty$
    { pop$ "" }
    { "\textit{" swap$ * "}" * }
  if$
}
FUNCTION {scaps}
{ duplicate$ empty$
    { pop$ "" }
    { "\textsc{" swap$ * "}" * }
  if$
}
FUNCTION {anglequote}
{ duplicate$ empty$
    { pop$ "" }
    { "<<" swap$ * ">>" * }
  if$
}
FUNCTION {singlequote}
{ duplicate$ empty$
    { pop$ "" }
    { "'{}" swap$ * "'{}" * }
  if$
}
FUNCTION {doublequote}
{ duplicate$ empty$
    { pop$ "" }
    { "``{}" swap$ * "''{}" * }
  if$
}
FUNCTION {format.names.author}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{ll, }{f.}{vv}{jj}" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #5 >
    { #4 'numnames :=
      #1 'showetal :=
    }
    { numnames #5 =
        { posothers #0 >
          { #1 'showetal :=
            #4 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ll, }{f.}{vv}{jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { showetal #0 >
                { ", " * t * }
                { " og " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$

  showetal #0 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {format.names.editor}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{ff }{vv }{ll }{jj }" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #5 >
    { #4 'numnames :=
      #1 'showetal :=
    }
    { numnames #5 =
        { posothers #0 >
          { #1 'showetal :=
            #4 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff }{vv }{ll }{jj }" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { showetal #0 >
                { ", " * t * }
                { " og " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$

  showetal #0 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }


FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {format.title.short}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  #1 #3 substring$
}
FUNCTION {format.unpublished.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.unpublished.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.unpublished.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.unpublished.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {unpublished}
{ output.bibitem
  author empty$
  'skip$
    {         format.unpublished.author
       output.nonnull.nostate
       " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.unpublished.title
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.unpublished.address
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.unpublished.year
       output.nonnull.nostate
       ". Upublisert materiale."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.misc.editor}
{ editor
  duplicate$ empty$ 'skip$
    { format.names.editor }
  if$
  "editor" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.misc.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.howpublished}
{ howpublished
  "howpublished" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.misc.url}
{ url
  "url" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {misc}
{ output.bibitem
  editor empty$
  'skip$
    {         format.misc.editor
       output.nonnull.nostate
       " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  author empty$
  'skip$
    {         format.misc.author
       output.nonnull.nostate
       " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.misc.publisher
       output.nonnull.nostate
       " "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {  "("
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.year
       output.nonnull.nostate
       "). "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.misc.title
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.misc.address
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  howpublished empty$
  'skip$
    {  "Lokalisert "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.howpublished
       output.nonnull.nostate
       ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  url empty$
  'skip$
    {  "\url{"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.misc.url
       output.nonnull.nostate
       "}"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.article.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.editor}
{ editor
  duplicate$ empty$ 'skip$
    { format.names.editor }
  if$
  "editor" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.article.volume}
{ volume
  "volume" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.howpublished}
{ howpublished
  "howpublished" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.url}
{ url
  "url" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {article}
{ output.bibitem
  author empty$
  'skip$
    {         format.article.author
       output.nonnull.nostate
    }
  if$
  new.block
  editor empty$
  'skip$
    {         format.article.editor
       output.nonnull.nostate
    }
  if$
  new.block
  year empty$
  'skip$
    {  "("
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.year
       output.nonnull.nostate
       "). "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.article.title
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  volume empty$
  'skip$
    {         format.article.volume
       output.nonnull.nostate
       ". utgave. "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.article.publisher
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  howpublished empty$
  'skip$
    {  "Lokalisert "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.howpublished
       output.nonnull.nostate
       ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  url empty$
  'skip$
    {  "\url{"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.article.url
       output.nonnull.nostate
       "}"
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.book.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.volume}
{ volume
  "volume" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {book}
{ output.bibitem
  title empty$
  'skip$
    {         format.book.title
       output.nonnull.nostate
       ". "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  author empty$
  'skip$
    {         format.book.author
       output.nonnull.nostate
    }
  if$
  new.block
  volume empty$
  'skip$
    {         format.book.volume
       output.nonnull.nostate
       ". utgave. "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.book.address
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.book.publisher
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.book.year
       output.nonnull.nostate
       "."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}

READ
STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}
EXECUTE {begin.bib}
EXECUTE {init.state.consts}
ITERATE {call.type$}
FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}EXECUTE {end.bib}