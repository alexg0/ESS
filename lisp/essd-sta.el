;;; essd-sta.el --- Stata customization

;; Copyright (C) 1997--1998 A. J. Rossini, Thomas Lumley

;; Author: A.J. Rossini <rossini@biostat.washington.edu>
;; Maintainer: A.J. Rossini <rossini@biostat.washington.edu>
;; Created: 9 Sep 1998
;; Modified: $Date: 1999/03/05 19:35:30 $
;; Version: $Revision: 1.12 $
;; RCS: $Id: essd-sta.el,v 1.12 1999/03/05 19:35:30 rossini Exp $
;;
;; Keywords: start up, configuration.

;; This file is part of ESS

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary: This file defines all the Stata customizations for
;;; ess-mode.  It is somewhat based on Stata-mode by Thomas Lumley
;;; <thomas@biostat.washington.edu>.

;;; Requires and Autoloads:

(require 'essl-sta)

(autoload 'inferior-ess "ess-inf" "Run an ESS process")
(autoload 'ess-mode     "ess-mode" "Edit an ESS process")

; Code:

(defvar STA-dialect-name "Stata"
  "Name of 'dialect' for Stata.");easily changeable in a user's .emacs

(defvar STA-customize-alist
  '((ess-local-customize-alist     . 'STA-customize-alist)
    (ess-language                  . "Stata")
    (ess-dialect                   . STA-dialect-name)
    (ess-suffix                    . "ado") 
    (ess-dump-filename-template    . (concat (user-login-name)
					     ".%s."
					     ess-suffix))
    (ess-mode-editing-alist        . STA-editing-alist)
    (ess-mode-syntax-table         . STA-syntax-table)
    (ess-mode-edit                 . 'STA-mode)
    (ess-help-sec-regex            . 'nil) ;ess-help-STA-sec-regex)
    (ess-help-sec-keys-alist       . 'nil) ;STA-help-sec-keys-alist)
    (ess-loop-timeout              . 100000 )
    (ess-object-name-db-file       . "ess-sta-namedb.el" )
    (ess-retr-lastvalue-command    . 'nil)
    (ess-save-lastvalue-command    . 'nil)
    (inferior-ess-program          . inferior-STA-program-name)
    (inferior-ess-objects-command  . "desc\n")
    (inferior-ess-help-command     . "set more off\n help %s\n set more on\n")
    (inferior-ess-exit-command     . "exit\n")
    (inferior-ess-primary-prompt   . "^. ?")
    (inferior-ess-secondary-prompt . "^. ?")
    (inferior-ess-start-file       . nil) ;"~/.ess-stata")
    (inferior-ess-start-args       . "")) ; "-q"
 "Variables to customize for Stata")


(defun STA-mode (&optional proc-name)
  "Major mode for editing Stata source.  See ess-mode for more help."
  (interactive)
  (setq ess-customize-alist STA-customize-alist)
  (ess-mode STA-customize-alist proc-name))


(defun stata (&optional start-args)
  "Call Stata."
  (interactive "P")
  (setq ess-customize-alist STA-customize-alist)
  (ess-write-to-dribble-buffer
   (format "(STA): ess-dialect=%s , buf=%s \n"
	   ess-dialect
	   (current-buffer)))
  (let ((sta-start-args
	 (concat inferior-ess-start-args
		 (if start-args (read-string
				 "Starting Args [possibly -q] ? ")
		   nil))))
    (inferior-ess sta-start-args)))


(defun STA-transcript-mode ()
  "Stata transcript mode."
  (interactive)
  (ess-transcript-mode STA-customize-alist))



 ; Provide package

(provide 'essd-sta)

 ; Local variables section

;;; This file is automatically placed in Outline minor mode.
;;; The file is structured as follows:
;;; Chapters:     ^L ;
;;; Sections:    ;;*;;
;;; Subsections: ;;;*;;;
;;; Components:  defuns, defvars, defconsts
;;;              Random code beginning with a ;;;;* comment

;;; Local variables:
;;; mode: emacs-lisp
;;; outline-minor-mode: nil
;;; mode: outline-minor
;;; outline-regexp: "\^L\\|\\`;\\|;;\\*\\|;;;\\*\\|(def[cvu]\\|(setq\\|;;;;\\*"
;;; End:

;;; essd-sta.el ends here
