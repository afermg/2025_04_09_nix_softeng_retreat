(setq org-export-with-smart-quotes t)

(setq org-latex-remove-logfiles nil)

(add-to-list 'org-latex-packages-alist '("" "org-preamble"))

(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

 (add-to-list 'org-latex-classes
       '("beamerposter"
         "\\documentclass[final]{beamer}
         \\usepackage[T1]{fontenc}
         \\usepackage{lmodern}
         \\usepackage[size=custom,width=120,height=91,scale=1.0]{beamerposter}  
         \\usepackage{graphicx}
         \\usepackage{booktabs}
         \\usepackage{tikz}
         \\usepackage{pgfplots}
         \\pgfplotsset{compat=1.18}
         \\usepackage{anyfontsize}

         [NO-DEFAULT-PACKAGES]"))

(setq org-latex-pdf-process '("latexmk -xelatex -shell-escape -quiet %f"))

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("org-plus-contrib" . "https://orgmode.org/elpa/") t)
(require 'ox-extra)
(ox-extras-activate '(ignore-headlines))

(message "Load path is %s" load-path)
 (require 'citeproc)
(message "Load path now is %s" load-path)


   (setq this-directory (file-name-directory (or load-file-name buffer-file-name)))
   (setq pub-directory (concat this-directory "pub/"))
   (unless (boundp 'org-publish-project-alist)
     (setq org-publish-project-alist nil))


   (add-to-list
    'org-publish-project-alist
    `("publish-pdf"
      :base-directory ,this-directory
      :base-extension "org"
      :publishing-directory ,pub-directory
      :publishing-function org-beamer-publish-to-pdf
      :exclude ".*publish.*.org\\|readme.org\\|qr.org\\|abstract.org"
      ;; :section-numbers 2
      :with-toc        nil
      :latex-class "beamerposter"
      ;; :latex-header-extra ""
      ))
   
 (add-to-list 'load-path "~/.emacs.d/elpa")
 (package-initialize)
 (package-install 'citeproc)

(defun org-publish-pdf ()
  (progn
    (org-publish-project "publish-pdf" 'force)
    (shell-command "mv ./latex.d pub/.; mv -f poster* *.sty ./pub/latex.d/.; mv ./pub/latex.d/poster*.org .")
    ))
