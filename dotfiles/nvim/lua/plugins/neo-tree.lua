return {
	require("neo-tree").setup({
	  -- Other configuration settings...
	  filesystem = {
	    filtered_items = {
	      visible = true, -- Make filtered items (like hidden files) visible
	      hide_dotfiles = false, -- Ensure dotfiles are not hidden
	      hide_gitignored = false, -- Optional: set to true if you want to see gitignored files as well
	      -- You can also use the `hide_by_name` list to specify any patterns you still want to hide
	      hide_by_name = {
	        -- List any specific files you want to keep hidden despite showing hidden files by default
	      },
	    },
	    -- Any other filesystem specific settings...
	  },
	  -- Rest of your Neo-tree setup configuration...
	})
}
