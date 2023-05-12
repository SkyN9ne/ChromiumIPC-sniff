ipcz_protocol = Proto("IPCZ",  "IPCZ Protocol")

local get_chrome_name = require("helpers\\common").get_chrome_type_name

-- IpczHeader fields
-- https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/libchrome/mojo/core/channel.h;l=135?q=IpczHeader
local header_size                  = ProtoField.int16 ("ipcz.headersize"             , "Header Size"     , base.DEC)
local num_handles            = ProtoField.int32 ("ipcz.numhandles"       , "Handles Count"         , base.DEC)
local total_size       = ProtoField.int32 ("ipcz.totalsize"       , "Total Message Size"         , base.DEC)

-- IPCZ MessageHeader
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/message.h;drc=11ff9071e6112d0b830036e7c5bc2b00560649c0;l=32?q=MessageHeaderV0&ss=chromium%2Fchromium%2Fsrc
local message_header_size    = ProtoField.uint8 ("ipcz.msgheadersize"  , "Header Size"     , base.DEC)
local version            = ProtoField.uint8 ("ipcz.version"       , "Header Version"         , base.DEC)
local message_id       = ProtoField.uint8 ("ipcz.messageid"       , "Message ID"         , base.DEC)
local reserved       = ProtoField.new ("Reserved" , "ipcz.reserved"                     ,   ftypes.BYTES)
local sequence_number = ProtoField.uint64 ("ipcz.seqnum"       , "Sequence Number"         , base.HEX)
local driver_object_data_array = ProtoField.uint32 ("ipcz.driverobjectoffset"       , "Driver Objects Array (pointer)"         , base.DEC)
local reserved2 = ProtoField.new ("Reserved 2" , "ipcz.reserved2"                     ,   ftypes.BYTES)

local raw_data              = ProtoField.new("Raw Data", "ipcz.data", ftypes.BYTES)

-- Struct Header
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/message.h;drc=11ff9071e6112d0b830036e7c5bc2b00560649c0;bpv=1;bpt=0;l=64
local struct_size = ProtoField.uint32 ("ipcz.structsize"       , "Struct Length"         , base.DEC)
local struct_version = ProtoField.uint32 ("ipcz.structversion"       , "Struct Version"         , base.DEC)

-- Array Header
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/message.h;l=75;drc=11ff9071e6112d0b830036e7c5bc2b00560649c0;bpv=1;bpt=0
local array_size = ProtoField.uint32 ("ipcz.arraysize"       , "Array Length"         , base.DEC)
local array_numelements = ProtoField.uint32 ("ipcz.arraynumelems"       , "Elements Count"         , base.DEC)

-- DriverObjectArrayData
-- https://source.chromium.org/chromium/chromium/src/+/main:third_party/ipcz/src/ipcz/message.h;l=108;drc=11ff9071e6112d0b830036e7c5bc2b00560649c0;bpv=1;bpt=1?q=kDataArray&ss=chromium%2Fchromium%2Fsrc
local first_object_index = ProtoField.uint32 ("ipcz.firstobjindex"       , "First Object Index"         , base.DEC)
local num_index = ProtoField.uint32 ("ipcz.numindex"       , "Elements Count"         , base.DEC)

-- DriverObjectData
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/message.h;l=89
local driver_data_array = ProtoField.uint32 ("ipcz.driver.dataarray"       , "Driver Data Array (pointer)"         , base.DEC)
local first_driver_handle = ProtoField.uint16 ("ipcz.driver.driverhandle"       , "First Driver Handle"         , base.DEC)
local num_driver_handles = ProtoField.uint16 ("ipcz.driver.numhandles"       , "Driver Handles Count"         , base.DEC)


-- Accept Parcel fields
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/node_messages_generator.h;l=298;drc=11ff9071e6112d0b830036e7c5bc2b00560649c0;bpv=1;bpt=1
local sublink_id = ProtoField.uint64 ("ipcz.ap.sublinkid"       , "Sublink ID"         , base.HEX)
local ap_seqnum = ProtoField.uint64 ("ipcz.ap.seqnum"       , "Sequence Number"         , base.HEX)
local ap_subpacel_index = ProtoField.uint32 ("ipcz.ap.subparcelindex"       , "Sub-Parcel Index"         , base.DEC)
local ap_num_subparcels = ProtoField.uint32 ("ipcz.ap.numsubpacels"       , "Sub-parcels Count"         , base.DEC)
local ap_pacel_fragment = ProtoField.new ("Shared Memory Fragment (Optional)", "ipcz.ap.parcelfragment"                , ftypes.BYTES)
local fragment_buffer_id = ProtoField.uint64 ("ipcz.buffid"       , "Fragment Buffer ID"         , base.HEX)
local fragment_offset = ProtoField.uint32 ("ipcz.memoffset"       , "Fragment Begin Offset (Inside Shared Buffer)"         , base.HEX)
local fragment_size = ProtoField.uint32 ("ipcz.fragsize"       , "Fragment Size"         , base.HEX)
local parcel_data_array = ProtoField.uint32 ("ipcz.paceldata"       , "Parcel Data Array (Pointer)"         , base.DEC)
local handles_types_array = ProtoField.uint32 ("ipcz.handletypes"       , "Handles Types Array (Pointer)"         , base.DEC)
local routers_descriptors_array = ProtoField.uint32 ("ipcz.routers"       , "New Routers Array (Pointer)"         , base.DEC)
local padding = ProtoField.new ("Padding", "ipcz.padding"         , ftypes.BYTES)
local driver_objects_array = ProtoField.new ("Driver Objects Range Info ", "ipcz.driverobjects"         , ftypes.BYTES)
local handle_type = ProtoField.uint32("ipcz.handletype", "Handle Type", base.DEC)

-- Router Descriptor
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/router_descriptor.h;l=25
local closed_peer_sequence_length = ProtoField.uint64("ipcz.router.peerseqlen", "Closed Peer Sequence Length", base.DEC)
local new_sublink = ProtoField.uint64("ipcz.router.newsublink", "New Sub-Link", base.DEC)
local new_link_state_fragment = ProtoField.new("New Link State Fragment", "ipcz.router.newlinkstate", ftypes.BYTES)
local new_decaying_sublink = ProtoField.uint64("ipcz.router.newdecaysublink", "New Decaying Sub-Link", base.DEC)
local next_outgoing_seqnum = ProtoField.uint64("ipcz.router.nextseqnum", "Next Outgoing Sequence Number", base.DEC)
local num_bytes_produced = ProtoField.uint64("ipcz.router.bytesproduced", "Total Outgoing Bytes Produced", base.DEC)
local next_incoming_sequence_number = ProtoField.uint64("ipcz.router.nextinseqnum", "Next Incoming Sequence Number", base.HEX)
local decaying_incoming_sequence_length = ProtoField.uint64("ipcz.router.decayinseqnum", "Decaying Incoming Sequence Length", base.DEC)
local num_bytes_consumed = ProtoField.uint64("ipcz.router.bytesconsumed", "Total Incoming Bytes Consumed", base.DEC)
local router_flags             = ProtoField.uint32 ("ipcz.router.flags"          , "Flags"         , base.HEX)
local flag_peer_closed = ProtoField.bool("ipcz.router.peerclosed", "peer_closed", 8, {"Other end of the route is closed", "Other end of the route is not known to be closed"}, 0x1)
local flag_proxy_already_bypassed = ProtoField.bool("ipcz.router.proxybypass", "proxy_already_bypassed", 8, {"Proxy was already bypassed", "Proxy was not bypassed"}, 0x2)
local router_reserved = ProtoField.new("Reserved", "ipcz.router.reserved", ftypes.BYTES) -- 7 bytes
local proxy_peer_node_name = ProtoField.new("Proxy Peer Node Name", "ipcz.router.proxypeernodename", ftypes.BYTES)
local proxy_peer_sublink = ProtoField.uint64("ipcz.router.proxypeersublink", "Proxy Peer Sublink", base.DEC)

-- Route Closed
local rc_sublink_id = ProtoField.uint64 ("ipcz.rc.sublinkid"       , "Sublink ID"         , base.HEX)
local rc_seqnum = ProtoField.uint64 ("ipcz.rc.seqnum"       , "Sequence Number"         , base.HEX)

-- Flush Router
local fr_sublink_id = ProtoField.uint64("ipcz.fr.sublinkid", "Sublink ID", base.HEX)

-- Relay Message
local rm_destination = ProtoField.new("Destination Node Name", "ipcz.rm.destination", ftypes.BYTES)
local rm_data = ProtoField.uint32("ipcz.rm.data", "Data (pointer)", base.DEC)
local rm_padding = ProtoField.new ("Padding", "ipcz.rm.padding"         , ftypes.BYTES) -- 4 bytes
local rm_driver_object_array = ProtoField.new ("Driver Objects Range Info", "ipcz.rm.driverobject"         , ftypes.BYTES)


-- Serialized driver/transport objects
-- Object Header
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/transport.cc;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=83
local driver_header_size = ProtoField.uint32("ipcz.driver.headersize", "Header Size", base.DEC)
local driver_type = ProtoField.uint32("ipcz.driver.type", "Driver Object Type", base.DEC)
local driver_num_handles = ProtoField.uint32("ipcz.driver.numhandles", "Handles Count", base.DEC)
local driver_handle_owner = ProtoField.uint8("ipcz.driver.handleowner", "Handle Owner", base.DEC)
local driver_padding = ProtoField.new ("Padding", "ipcz.driver.padding"         , ftypes.BYTES) -- 3 bytes
local driver_object_body = ProtoField.new ("Driver Object Body", "ipcz.driver.body"         , ftypes.BYTES)

-- DataPipeHeader
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/data_pipe.cc;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=29
local data_pipe_header_size = ProtoField.uint32("ipcz.datapipe.headersize", "Header Size", base.DEC)
local data_pipe_endpoint_type = ProtoField.uint32("ipcz.datapipe.endpointtype", "Endpoint Type", base.DEC)
local data_pipe_element_size = ProtoField.uint32("ipcz.datapipe.elementsize", "Element Size", base.DEC)
local data_pipe_padding = ProtoField.new("Padding", "ipcz.datapipe.padding", ftypes.BYTES) -- 4 bytes
local data_pipe_ring_buffer_state = ProtoField.new("Ring Buffer State", "ipcz.datapipe.ringbufferstate", ftypes.BYTES) -- 8 bytes

-- RingBuffer::SerializedState
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/ring_buffer.h;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=151
local ring_buffer_offset = ProtoField.uint32("ipcz.datapipe.offset", "Ring Buffer Offset", base.HEX)
local ring_buffer_size = ProtoField.uint32("ipcz.datapipe.size", "Ring Buffer Size", base.HEX)

-- SharedBuffer's BufferHeader
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/shared_buffer.cc;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=29
local shared_buffer_header_size = ProtoField.uint32("ipcz.sharedbuffer.headersize", "Header Size", base.DEC)
local shared_buffer_buffer_size = ProtoField.uint32("ipcz.sharedbuffer.buffersize", "Buffer Size", base.HEX)
local shared_buffer_buffer_mode = ProtoField.uint32("ipcz.sharedbuffer.mode", "Mode", base.DEC)
local shared_buffer_padding = ProtoField.new("Padding", "ipcz.sharedbuffer.padding", ftypes.BYTES) -- 4 bytes
local shared_buffer_guid = ProtoField.new("Identifying GUID", "ipcz.sharedbuffer.guid", ftypes.GUID) -- 8 bytes

-- TransportHeader
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/transport.cc;l=105;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1
local transport_destination_type = ProtoField.uint32("ipcz.transport.destinationtype", "Destination Type", base.DEC)
local transport_is_same_remote_process = ProtoField.uint8("ipcz.transport.issameremoteprocess", "Is same remote process", base.DEC)
local transport_is_peer_trusted = ProtoField.uint8("ipcz.transport.ispeertrusted", "Is peer trusted", base.DEC)
local transport_is_trusted_by_peer = ProtoField.uint8("ipcz.transport.istrustedbypeer", "Is trusted by peer", base.DEC)
local transport_padding = ProtoField.new("Padding", "ipcz.transport.padding", ftypes.BYTES) -- 1 bytes

-- WrappedPlatformHandleHeader
-- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/wrapped_platform_handle.cc;l=56;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1
local wrapped_handle_size = ProtoField.uint32("ipcz.wrappedhandle.headersize", "Header Size", base.DEC)
local wrapped_handle_type = ProtoField.uint32("ipcz.wrappedhandle.type", "Wrapped Handle Type", base.DEC)



ipcz_protocol.fields = {
  header_size, num_handles, total_size,   -- IpczHeader
  message_header_size, version, message_id, reserved, sequence_number, driver_object_data_array, reserved2,     -- Message Header
  sublink_id, ap_seqnum, ap_subpacel_index, ap_num_subparcels, ap_pacel_fragment, fragment_buffer_id, fragment_offset, fragment_size, parcel_data_array, handles_types_array, routers_descriptors_array, padding, driver_objects_array, handle_type,  -- Accept Parcel fields
  rc_sublink_id, rc_seqnum,                                                                                   -- Route Closed
  fr_sublink_id,                                                                                              -- Flush Router
  rm_destination, rm_data, rm_padding,rm_driver_object_array,                                                   -- Relay Message
  struct_size, struct_version, array_size, array_numelements,                                                  -- Struct Header & Array Header
  first_object_index,  num_index,                                                                               -- DriverObjectArrayData
  driver_data_array, first_driver_handle, num_driver_handles,                                                  -- DriverObjectData
  closed_peer_sequence_length, new_sublink, new_link_state_fragment, new_decaying_sublink, next_outgoing_seqnum, num_bytes_produced, next_incoming_sequence_number, decaying_incoming_sequence_length, num_bytes_consumed, router_flags, flag_peer_closed, flag_proxy_already_bypassed, router_reserved, proxy_peer_node_name, proxy_peer_sublink, -- Router Descriptor
  driver_header_size, driver_type, driver_num_handles, driver_handle_owner, driver_padding,  driver_object_body,  -- Driver ObjectHeader
  data_pipe_header_size, data_pipe_endpoint_type, data_pipe_element_size, data_pipe_padding, data_pipe_ring_buffer_state,    -- DataPipeHeader
  ring_buffer_offset, ring_buffer_size,                                                                             -- RingBuffer::SerializedState
  shared_buffer_header_size, shared_buffer_buffer_size, shared_buffer_buffer_mode, shared_buffer_padding, shared_buffer_guid,    -- SharedBuffer's BufferHeader
  transport_destination_type, transport_is_same_remote_process, transport_is_peer_trusted, transport_is_trusted_by_peer, transport_padding, -- TransportHeader
  wrapped_handle_size, wrapped_handle_type,                                                                     -- WrappedPlatformHandleHeader
  raw_data,                                                                                                      -- Extra Fields
}

ipcz_protocol.experts = {expert_info_pipeerror}

local _header_size = Field.new("ipcz.headersize")
local _num_handles = Field.new("ipcz.numhandles")
local _total_size = Field.new("ipcz.totalsize")
local _driverobjectsoffset = Field.new("ipcz.driverobjectoffset")

local _msg_hdr_size = Field.new("ipcz.structsize")

local _msg_header_size = Field.new("ipcz.msgheadersize")
local _version = Field.new("ipcz.version")
local _msg_id = Field.new("ipcz.messageid")
local _reserved1 = Field.new("ipcz.reserved")
local _driverobjectoffset = Field.new("ipcz.driverobjectoffset")
local _reserved2 = Field.new("ipcz.reserved2")

-- Accept Parcel fields
local _bufferid = Field.new("ipcz.buffid")
local _parcel_data_offset = Field.new("ipcz.paceldata")
local _handle_types_offset = Field.new("ipcz.handletypes")
local _routers_offset = Field.new("ipcz.routers")

-- Relay Message Fields
local _rm_data_offset = Field.new("ipcz.rm.data")


function ipcz_protocol.dissector(buffer, pinfo, tree)
    length = buffer:len()
    if length == 0 then return end

    pinfo.src = Address.ip('127.0.0.1')
    pinfo.dst = Address.ip('127.0.0.1')
    pinfo.cols.protocol = ipcz_protocol.name

    local        subtree =    tree:add(ipcz_protocol, buffer(), "IPCZ Protocol Message")

    -- Generic Header
    
    local headerSubtree = subtree:add("IPCZ Generic Header")

    local offset = 0
    header_size_value = buffer(offset,2):le_uint()
    headerSubtree:add_le(header_size,                buffer(offset,2))            offset = offset + 2
    headerSubtree:add_le(num_handles,          buffer(offset,2));                 offset = offset + 2
    headerSubtree:add_le(total_size,            buffer(offset,4));                offset = offset + 4

    headerSubtree:set_len(header_size_value)

    message_size = _total_size()() - header_size_value

    -- IPCZ message header

    local message_start_offset = offset
    offset, message_name = read_ipcz_message_header(subtree, offset, buffer, message_size)
   

    local eventDataSubstree = subtree:add(buffer(offset), "Message Data")

    eventDataSubstree:append_text(" (" .. message_name .. ")")
    subtree:append_text(", Message ID: " .. _msg_id()() .. " [" .. message_name .. "]")

    -- TODO: move to a function called read_struct_header(subtree, initial_offset, buffer)
    eventDataSubstree:add_le(struct_size, buffer(offset, 4));                 offset = offset + 4
    eventDataSubstree:add_le(struct_version, buffer(offset, 4));                 offset = offset + 4

    eventDataSubstree:set_len(_msg_hdr_size()())

    local paramsTree = eventDataSubstree:add(buffer(offset, _msg_hdr_size()() - 8), "Serialized Parameters")


    -- Now message ID dispatching, based on 
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/node_messages_generator.h
    if _msg_id()() == 0 then
        -- ConnectFromBrokerToNonBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ConnectFromBrokerToNonBroker"
    elseif _msg_id()() == 1 then
        -- ConnectFromNonBrokerToBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ConnectFromNonBrokerToBroker"
    elseif _msg_id()() == 2 then
        -- ReferNonBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ReferNonBroker"
    elseif _msg_id()() == 3 then
        -- ConnectToReferredBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ConnectToReferredBroker"
    elseif _msg_id()() == 4 then
        -- ConnectToReferredNonBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ConnectToReferredNonBroker"
    elseif _msg_id()() == 5 then
        -- NonBrokerReferralAccepted
        pinfo.cols.info = tostring(pinfo.cols.info) .. " NonBrokerReferralAccepted"
    elseif _msg_id()() == 6 then
        -- NonBrokerReferralRejected
        pinfo.cols.info = tostring(pinfo.cols.info) .. " NonBrokerReferralRejected"
    elseif _msg_id()() == 7 then
        -- ConnectFromBrokerToBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ConnectFromBrokerToBroker"
    elseif _msg_id()() == 10 then
        -- ConnectFromBrokerToNonBroker
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RequestIntroduction"
    elseif _msg_id()() == 11 then
        -- AcceptIntroduction
        pinfo.cols.info = tostring(pinfo.cols.info) .. " AcceptIntroduction"
    elseif _msg_id()() == 12 then
        -- RejectIntroduction
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RejectIntroduction"
    elseif _msg_id()() == 13 then
        -- RequestIndirectIntroduction
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RequestIndirectIntroduction"
    elseif _msg_id()() == 14 then
        -- AddBlockBuffer
        pinfo.cols.info = tostring(pinfo.cols.info) .. " AddBlockBuffer"
    elseif _msg_id()() == 20 then
        --
        -- AcceptParcel
        --

        paramsTree:add_le(sublink_id,  buffer(offset,8));             offset = offset + 8
        paramsTree:add_le(ap_seqnum,  buffer(offset,8));             offset = offset + 8
        paramsTree:add_le(ap_subpacel_index,  buffer(offset,4));             offset = offset + 4
        paramsTree:add_le(ap_num_subparcels,  buffer(offset,4));             offset = offset + 4

        -- shared memory fragment
        local sharedMemoryTree = paramsTree:add(buffer(offset,16), "Shared Memory Fragment");            
        offset = read_fragment_descriptor(sharedMemoryTree, offset, buffer)

        parcelDataTree = paramsTree:add_le(parcel_data_array,  buffer(offset,4));             offset = offset + 4
        handleTypesTree = paramsTree:add_le(handles_types_array,  buffer(offset,4));             offset = offset + 4
        routersTree = paramsTree:add_le(routers_descriptors_array,  buffer(offset,4));             offset = offset + 4
        paramsTree:add(padding,  buffer(offset,4));             offset = offset + 4

        driver_objects_tree = paramsTree:add(buffer(offset,8), "Driver Objects Range Info");  
        offset = read_DriverObjectArrayData(driver_objects_tree, offset, buffer)

        local is_memory_fragment_null = _bufferid()() > 100000000 -- actually should be == 0xffffffffffffffff
        if not is_memory_fragment_null then
            pinfo.cols.info = tostring(pinfo.cols.info) .. " AcceptParcel (with shared memory fragment)"
        else
            sharedMemoryTree:append_text(" [NULL]")
        end

        -- Now take care of the possible arrays in the arrays area

        if _parcel_data_offset()() > 0 and is_memory_fragment_null then
            local offset2 = message_start_offset + _parcel_data_offset()()
            parcelDataArrayHeaderTree = paramsTree:add(buffer(offset2, 8), "Parcel Data Array Header (pointer: " .. _parcel_data_offset()() .. ")")

            parcel_length = buffer(offset2+4,4):le_uint()
            offset2 = read_array_header(parcelDataArrayHeaderTree, offset2, buffer)

            if parcel_length > 4 then
                Dissector.get("mojouser"):call(buffer(offset2, parcel_length):tvb(), pinfo, tree)
            else
                -- I don't know what's this
                pinfo.cols.info = tostring(pinfo.cols.info) .. " Data"
                Dissector.get("data"):call(buffer(offset2, parcel_length):tvb(), pinfo, tree)
            end
        elseif _parcel_data_offset()() == 0 then
            parcelDataTree:append_text(" [NULL]")
        end

        if _handle_types_offset()() > 0 then
            offset2 = message_start_offset + _handle_types_offset()()

            local array_length = buffer(offset2, 4):le_uint()
            local num_elements = buffer(offset2+4,4):le_uint()
            handleTypesArrayTree = paramsTree:add(buffer(offset2, array_length), "Handle Types Array (pointer: " .. _handle_types_offset()() .. ")")
            offset2 = read_array_header(handleTypesArrayTree, offset2, buffer)

             -- read the handle types array contents
            local handle_index = 0
            while (handle_index < num_elements) do
                handle_type_value = buffer(offset2, 4):le_uint()
                handleTypesArrayTree:add_le(handle_type, buffer(offset2, 4)):append_text(" [" .. get_handle_type(handle_type_value) .. "]");  offset2 = offset2 + 4

                handle_index = handle_index + 1
            end
        else
            handleTypesTree:append_text(" [NULL]")
        end

        if _routers_offset()() > 0 then
            offset2 = message_start_offset + _routers_offset()()

            local array_length = buffer(offset2, 4):le_uint()
            local num_elements = buffer(offset2+4,4):le_uint()
            routersArrayTree = paramsTree:add(buffer(offset2, array_length), "New Routers Array (pointer: " .. _routers_offset()() .. ")")
            offset2 = read_array_header(routersArrayTree, offset2, buffer)

            -- read the routers array contents
            local router_descriptor_size = 112
            local router_index = 0
            while (router_index < num_elements) do
                
                local routerTree = routersArrayTree:add(buffer(offset2, router_descriptor_size), "Router #" .. (router_index+1))
                offset2 = read_router_descriptor(routerTree, offset2, buffer)
                router_index = router_index + 1
            end
        else
            routersTree:append_text(" [NULL]")
        end
        

    elseif _msg_id()() == 21 then
        -- AcceptParcelDriverObjects
        pinfo.cols.info = tostring(pinfo.cols.info) .. " AcceptParcelDriverObjects"
    elseif _msg_id()() == 22 then
        -- RouteClosed
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RouteClosed"
        paramsTree:add_le(rc_sublink_id,  buffer(offset,8));             offset = offset + 8
        paramsTree:add_le(rc_seqnum,  buffer(offset,8));             offset = offset + 8

    elseif _msg_id()() == 23 then
        -- RouteDisconnected
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RouteDisconnected"
    elseif _msg_id()() == 30 then
        -- BypassPeer
        pinfo.cols.info = tostring(pinfo.cols.info) .. " BypassPeer"
    elseif _msg_id()() == 31 then
        -- AcceptBypassLink
        pinfo.cols.info = tostring(pinfo.cols.info) .. " AcceptBypassLink"
    elseif _msg_id()() == 32 then
        -- StopProxying
        pinfo.cols.info = tostring(pinfo.cols.info) .. " StopProxying"
    elseif _msg_id()() == 33 then
        -- ProxyWillStop
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ProxyWillStop"
    elseif _msg_id()() == 34 then
        -- BypassPeerWithLink
        pinfo.cols.info = tostring(pinfo.cols.info) .. " BypassPeerWithLink"
    elseif _msg_id()() == 35 then
        -- StopProxyingToLocalPeer
        pinfo.cols.info = tostring(pinfo.cols.info) .. " StopProxyingToLocalPeer"
    elseif _msg_id()() == 36 then
        -- FlushRouter
        pinfo.cols.info = tostring(pinfo.cols.info) .. " FlushRouter"
        
        paramsTree:add_le(fr_sublink_id, buffer(offset, 8));            offset = offset + 8
    elseif _msg_id()() == 64 then
        -- RequestMemory
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RequestMemory"
    elseif _msg_id()() == 65 then
        -- ProvideMemory
        pinfo.cols.info = tostring(pinfo.cols.info) .. " ProvideMemory"
    elseif _msg_id()() == 66 then
        --
        -- RelayMessage
        --
        pinfo.cols.info = tostring(pinfo.cols.info) .. " RelayMessage"

        paramsTree:add_le(rm_destination, buffer(offset, 16));            offset = offset + 16
        paramsTree:add_le(rm_data,  buffer(offset,4));             offset = offset + 4
        paramsTree:add_le(rm_padding, buffer(offset, 4));            offset = offset + 4
        driver_objects_tree = paramsTree:add(buffer(offset,8), "Driver Objects Range Info");  
        offset = read_DriverObjectArrayData(driver_objects_tree, offset, buffer)

        -- Now take care of the possible arrays in the arrays area

        if _rm_data_offset()() > 0 then
            local offset2 = message_start_offset + _rm_data_offset()()

            array_length = buffer(offset2,4):le_uint()
            data_length = buffer(offset2+4,4):le_uint()

            local dataArrayTree = paramsTree:add(buffer(offset2, array_length), "Data Array (pointer: " .. _rm_data_offset()() .. ")")

            dataArrayHeaderTree = dataArrayTree:add(buffer(offset2, 8), "Data Array Header")
            offset2 = read_array_header(dataArrayHeaderTree, offset2, buffer)

            dataTree = dataArrayTree:add(buffer(offset2, data_length), "IPCZ message to relay")

            local message_header_start_offset = offset2
            offset2, message_name = read_ipcz_message_header(dataTree, offset2, buffer, data_length)
            local header_size = offset2 - message_header_start_offset
            local messageDataTree = dataTree:add(buffer(offset2, data_length - header_size), "Message Data")

            dataTree:append_text(" [" .. message_name .. "]")

            pinfo.cols.info = tostring(pinfo.cols.info) .. " [" .. message_name .. "]"
        end

    elseif _msg_id()() == 67 then
        -- AcceptRelayedMessage
        pinfo.cols.info = tostring(pinfo.cols.info) .. " AcceptRelayedMessage"
    end

    --
    -- Handle attached driver objects
    --

    local num_drivers = 0
    local driver_data_arrays = {}
    if _driverobjectsoffset()() > 0 then
        local offset2 = message_start_offset + _driverobjectsoffset()()
        local array_length = buffer(offset2,4):le_uint()
        num_drivers = buffer(offset2+4,4):le_uint()

        local driverObjectsTree = paramsTree:add(buffer(offset2, array_length), "Driver Objects Array (pointer: " .. _driverobjectsoffset()() .. ")")
        local driverObjectsArrayHeaderTree = driverObjectsTree:add(buffer(offset2, 8), "Array Header")
        offset2 = read_array_header(driverObjectsArrayHeaderTree, offset2, buffer)

        -- read the driver objects array contents
        -- local driverObjectsTree = driverObjectsTree:add(buffer(offset2, array_length-8), "Array Contents")
        local driver_descriptor_size = 8
        local driver_index = 0
        while (driver_index < num_drivers) do
            local driverTree = driverObjectsTree:add(buffer(offset2, driver_descriptor_size), "Driver #" .. (driver_index+1))
            offset2, driver_data_offset = read_driver_object(driverTree, offset2, buffer)
            table.insert(driver_data_arrays, driver_data_offset)
            driver_index = driver_index + 1
        end

        for index, driver_data_array_offset in ipairs(driver_data_arrays) do

            local offset3 = message_start_offset + driver_data_array_offset
            local array_length = buffer(offset3,4):le_uint()
            local num_bytes = buffer(offset3+4,4):le_uint()
            local driverDataArrayTree = paramsTree:add(buffer(offset3, array_length), "Driver #" .. (index) .. " Data Array (pointer: " .. driver_data_array_offset .. ")")
            local driverDataArrayHeaderTree = driverDataArrayTree:add(buffer(offset3, 8), "Array Header")
            offset3 = read_array_header(driverDataArrayHeaderTree, offset3, buffer)

            -- we assume this is the Mojo IpzDriver
            local driverArrayContetnsTree = driverDataArrayTree:add(buffer(offset3, num_bytes), "Array Contents (driver-specific serialization)")
            offset3, drivers_num_handles = read_mojo_driver_object_data(driverArrayContetnsTree, offset3, buffer, num_bytes) 
        end

    end

    subtree:append_text(", Attached Driver Objects: " .. num_drivers)

end

function read_DriverObjectArrayData( subtree, offset, buffer )
	subtree:add_le(first_object_index, buffer(offset, 4));        offset = offset + 4
    subtree:add_le(num_index, buffer(offset, 4));                 offset = offset + 4

    return offset
end

function read_fragment_descriptor(subtree, offset, buffer)
    subtree:add_le(fragment_buffer_id,  buffer(offset,8));        offset = offset + 8
    subtree:add_le(fragment_offset,  buffer(offset,4));           offset = offset + 4
    subtree:add_le(fragment_size,  buffer(offset,4));             offset = offset + 4

    return offset
end

function read_array_header( subtree, offset, buffer )
	subtree:add_le(array_size, buffer(offset, 4));                   offset = offset + 4
    subtree:add_le(array_numelements, buffer(offset, 4));           offset = offset + 4

    return offset
end


function read_driver_object(subtree, offset, buffer)
    subtree:add_le(driver_data_array, buffer(offset, 4));  local data_offset = buffer(offset, 4):le_uint();             offset = offset + 4
    subtree:add_le(first_driver_handle, buffer(offset, 2));                                                             offset = offset + 2
    subtree:add_le(num_driver_handles, buffer(offset, 2));                                                              offset = offset + 2

    return offset, data_offset
end


function read_mojo_driver_object_data(subtree, offset, buffer, object_length)
    --
    -- Transport::DeserializeObject
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/transport.cc;l=466;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1
    --
    local header_length = buffer(offset,4):le_uint()

    local headerTree = subtree:add(buffer(offset, header_length), "Driver Object Header")

                            headerTree:add_le(driver_header_size, buffer(offset, 4));                                                                           offset = offset + 4
    local driverTypeTree =  headerTree:add_le(driver_type, buffer(offset, 4));                  local driver_type_value = buffer(offset, 4):le_uint();          offset = offset + 4
                            headerTree:add_le(driver_num_handles, buffer(offset, 4));          local num_handles_value = buffer(offset, 4):le_uint();           offset = offset + 4
    local driverHandleOwnerTree = headerTree:add_le(driver_handle_owner, buffer(offset, 1));   local driver_handle_owner_value = buffer(offset, 1):le_uint();   offset = offset + 1
                            headerTree:add(padding, buffer(offset, 3));                                                                                         offset = offset + 3

    driverTypeTree:append_text(" [" .. get_driver_object_type(driver_type_value) .. "]")
    driverHandleOwnerTree:append_text(" [" .. get_driver_object_handle_owner(driver_handle_owner_value) .. "]")

    -- read handles list
    local handle_size = 8
    local handle_index = 0
    while (handle_index < num_handles_value) do
        local handle_value = buffer(offset, handle_size):le_uint64()
        subtree:add(buffer(offset, handle_size), "Handle #" .. (handle_index+1) .. " Value: " .. handle_value);     offset = offset + handle_size
        handle_index = handle_index + 1
    end
    local handles_area_size = handle_size * num_handles_value

    local driver_body_size = object_length - header_length - handles_area_size
    local driverObjectBodyTree = subtree:add(buffer(offset, driver_body_size), "Driver Object Body (" .. get_driver_object_type(driver_type_value) .. ")")
    
    -- Now read the driver object data according to its Type
    if driver_type_value == 0 then
        -- kTransport
        offset = read_transport(driverObjectBodyTree, offset, buffer, driver_body_size)
    elseif driver_type_value == 1 then
        -- kSharedBuffer
        offset = read_shared_buffer(driverObjectBodyTree, offset, buffer)
    elseif driver_type_value == 3 then
        -- kTransmissiblePlatformHandle
    elseif driver_type_value == 4 then
        -- kWrappedPlatformHandle
        local wrapped_header_length_value = buffer(offset,4):le_uint()
        local wrappedHandleTree = driverObjectBodyTree:add(buffer(offset, wrapped_header_length_value), "Wrapped Platform Handle Header")
        wrappedHandleTree:add_le(wrapped_handle_size, buffer(offset, 4));                                                     offset = offset + 4
        wrappedHandleTree:add_le(wrapped_handle_type, buffer(offset, 4)):append_text(" [kTransmissible]");                    offset = offset + 4 -- should always be 0 on Windows

        
    elseif driver_type_value == 5 then
        -- DataPipe
        offset = read_datapipe(driverObjectBodyTree, offset, buffer)
    end

    return offset, num_handles_value
end

function read_datapipe(subtree, offset, buffer)
    local header_length = buffer(offset,4):le_uint()

    local headerTree = subtree:add(buffer(offset, header_length), "Data Pipe Header")

    headerTree:add_le(data_pipe_header_size, buffer(offset, 4));                                            offset = offset + 4
    local endpointTypeTree = headerTree:add_le(data_pipe_endpoint_type, buffer(offset, 4)); 
    local endpoint_type_value = buffer(offset, 4):le_uint();                                            offset = offset + 4
    headerTree:add_le(data_pipe_element_size, buffer(offset, 4));                                       offset = offset + 4
    headerTree:add(data_pipe_padding, buffer(offset, 4));                                            offset = offset + 4
    local ringBufferTree = headerTree:add(data_pipe_ring_buffer_state, buffer(offset, 8));                                            
    ringBufferTree:add_le(ring_buffer_offset, buffer(offset, 4));                                          offset = offset + 4
    ringBufferTree:add_le(ring_buffer_size, buffer(offset, 4));                                            offset = offset + 4

    endpointTypeTree:append_text(" [" .. get_datapipe_endpoint_type(endpoint_type_value) .. "]")

    offset = read_shared_buffer(subtree, offset, buffer)

    return offset

end

function read_transport(subtree, offset, buffer, object_length)

    local headerTree = subtree:add(buffer(offset, object_length), "Transport Header")

    local transportTypeTree = headerTree:add_le(transport_destination_type, buffer(offset, 4)); 
    local transport_type_value = buffer(offset, 4):le_uint();                                            offset = offset + 4
    headerTree:add_le(transport_is_same_remote_process, buffer(offset, 1));                              offset = offset + 1
    headerTree:add_le(transport_is_peer_trusted, buffer(offset, 1));                              offset = offset + 1
    headerTree:add_le(transport_is_trusted_by_peer, buffer(offset, 1));                              offset = offset + 1
    headerTree:add(transport_padding, buffer(offset, 1));                                            offset = offset + 1

    transportTypeTree:append_text(" [" .. get_transport_endpoint_type(transport_type_value) .. "]")

    return offset
end

function read_shared_buffer(subtree, offset, buffer)
    local shared_buffer_header_length = buffer(offset,4):le_uint()
    local sharedBufferTree = subtree:add(buffer(offset, shared_buffer_header_length), "Shared Buffer Header")
    sharedBufferTree:add_le(shared_buffer_header_size, buffer(offset, 4));                                            offset = offset + 4
    sharedBufferTree:add_le(shared_buffer_buffer_size, buffer(offset, 4));                                            offset = offset + 4
    local sharedBufferModeTree = sharedBufferTree:add_le(shared_buffer_buffer_mode, buffer(offset, 4)); 
    local shared_buffer_mode_value = buffer(offset, 4):le_uint();                                            offset = offset + 4
    sharedBufferTree:add(shared_buffer_padding, buffer(offset, 4));                                            offset = offset + 4
    sharedBufferTree:add_le(shared_buffer_guid, buffer(offset, 16));                                            offset = offset + 16

    sharedBufferModeTree:append_text(" [" .. get_sharedbuffer_mode(shared_buffer_mode_value) .. "]")

    return offset
end

function get_datapipe_endpoint_type(type_id)
    --
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/data_pipe.h;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=41
    --
    local handle_type = "Unknown"

    if type_id == 0 then handle_type = "kProducer" end
    if type_id == 1 then handle_type = "kConsumer" end

    return handle_type
end

function get_transport_endpoint_type(type_id)
    --
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/transport.h;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=34
    --
    local handle_type = "Unknown"

    if type_id == 0 then handle_type = "kBroker" end
    if type_id == 1 then handle_type = "kNonBroker" end

    return handle_type
end

function get_sharedbuffer_mode(type_id)
    --
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/shared_buffer.cc;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=22
    --
    local handle_type = "Unknown"

    if type_id == 0 then handle_type = "kReadOnly" end
    if type_id == 1 then handle_type = "kWritable" end
    if type_id == 2 then handle_type = "kUnsafe" end

    return handle_type
end

function read_router_descriptor(subtree, offset, buffer)
    subtree:add_le(closed_peer_sequence_length, buffer(offset, 8));         offset = offset + 8
    subtree:add_le(new_sublink, buffer(offset, 8));                         offset = offset + 8
    local newFragmentTree = subtree:add(new_link_state_fragment, buffer(offset, 16));
    offset = read_fragment_descriptor(newFragmentTree, offset, buffer)
    subtree:add_le(new_decaying_sublink, buffer(offset, 8));                 offset = offset + 8
    subtree:add_le(next_outgoing_seqnum, buffer(offset, 8));                 offset = offset + 8
    subtree:add_le(num_bytes_produced, buffer(offset, 8));                   offset = offset + 8
    subtree:add_le(next_incoming_sequence_number, buffer(offset, 8));        offset = offset + 8
    subtree:add_le(decaying_incoming_sequence_length, buffer(offset, 8));    offset = offset + 8
    subtree:add_le(num_bytes_consumed, buffer(offset, 8));                   offset = offset + 8

    local flagsTree = subtree:add(router_flags, buffer(offset, 1));            
    flagsTree:add_le(flag_peer_closed, buffer(offset, 1))
    flagsTree:add_le(flag_proxy_already_bypassed, buffer(offset, 1))
    offset = offset + 1

    subtree:add(router_reserved, buffer(offset, 7));                        offset = offset + 7
    subtree:add(proxy_peer_node_name, buffer(offset, 16));                 offset = offset + 16
    subtree:add_le(proxy_peer_sublink, buffer(offset, 8));                 offset = offset + 8

    return offset
end


function read_ipcz_message_header(subtree, offset, buffer, message_size)
    local messageHeaderSubtree = subtree:add(buffer(offset, message_size), "Message Header")
                    messageHeaderSubtree:add_le(message_header_size,      buffer(offset,1));                                                            offset = offset + 1
                    messageHeaderSubtree:add_le(version,                   buffer(offset,1));                                                           offset = offset + 1
    msg_id_tree =   messageHeaderSubtree:add_le(message_id,                buffer(offset,1));    local msg_id_value = buffer(offset,1):le_uint();       offset = offset + 1
                    messageHeaderSubtree:add(reserved,                     buffer(offset,5));                                                           offset = offset + 5
                    messageHeaderSubtree:add_le(sequence_number,           buffer(offset,8));                                                           offset = offset + 8
                    messageHeaderSubtree:add_le(driver_object_data_array,  buffer(offset,4));                                                           offset = offset + 4
                    messageHeaderSubtree:add(reserved2,                    buffer(offset,4));                                                           offset = offset + 4

    local message_name = get_message_name(msg_id_value)
    msg_id_tree:append_text(" [" .. message_name .. "]")

    messageHeaderSubtree:set_len(_msg_header_size()())

    return offset, message_name
end

function get_handle_type(type_id)
    --
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/handle_type.h
    --
    local handle_type = "Unknown"

    if type_id == 0 then handle_type = "kPortal" end
    if type_id == 1 then handle_type = "kBoxedDriverObject" end
    if type_id == 2 then handle_type = "kRelayedBoxedDriverObject" end
    if type_id == 3 then handle_type = "kBoxedSubparcel" end

    return handle_type
end

function get_driver_object_type(type_id)
    --
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/object.h;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1;l=31
    --
    local handle_type = "Unknown"

    if type_id == 0 then handle_type = "kTransport" end
    if type_id == 1 then handle_type = "kSharedBuffer" end
    if type_id == 2 then handle_type = "kSharedBufferMapping" end
    if type_id == 3 then handle_type = "kTransmissiblePlatformHandle" end
    if type_id == 4 then handle_type = "kWrappedPlatformHandle" end
    if type_id == 5 then handle_type = "kDataPipe" end
    if type_id == 6 then handle_type = "kMojoTrap" end
    if type_id == 7 then handle_type = "kInvitation" end


    return handle_type
end

function get_driver_object_handle_owner(owner_id)
    --
    -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:mojo/core/ipcz_driver/transport.cc;l=58;drc=b18d59d36ac77ddf968b6e3452109e67471ee38f;bpv=1;bpt=1
    --
    local owner_type = "Unknown"

    if owner_id == 0 then owner_type = "kSender" end
    if owner_id == 1 then owner_type = "kRecipient" end


    return owner_type
end


function get_message_name(msg_id)
  --
  -- https://source.chromium.org/chromium/chromium/src/+/refs/heads/main:third_party/ipcz/src/ipcz/node_messages_generator.h
  --

  local msg_name = "Unknown"

  if msg_id == 0 then msg_name = "ConnectFromBrokerToNonBroker" end
  if msg_id == 1 then msg_name = "ConnectFromNonBrokerToBroker" end
  if msg_id == 2 then msg_name = "ReferNonBroker" end
  if msg_id == 3 then msg_name = "ConnectToReferredBroker" end
  if msg_id == 4 then msg_name = "ConnectToReferredNonBroker" end
  if msg_id == 5 then msg_name = "NonBrokerReferralAccepted" end
  if msg_id == 6 then msg_name = "NonBrokerReferralRejected" end
  if msg_id == 7 then msg_name = "ConnectFromBrokerToBroker" end
  if msg_id == 10 then msg_name = "RequestIntroduction" end
  if msg_id == 11 then msg_name = "AcceptIntroduction" end
  if msg_id == 12 then msg_name = "RejectIntroduction" end
  if msg_id == 13 then msg_name = "RequestIndirectIntroduction" end
  if msg_id == 14 then msg_name = "AddBlockBuffer" end
  if msg_id == 20 then msg_name = "AcceptParcel" end
  if msg_id == 21 then msg_name = "AcceptParcelDriverObjects" end
  if msg_id == 22 then msg_name = "RouteClosed" end
  if msg_id == 23 then msg_name = "RouteDisconnected" end
  if msg_id == 30 then msg_name = "BypassPeer" end
  if msg_id == 31 then msg_name = "AcceptBypassLink" end
  if msg_id == 32 then msg_name = "StopProxying" end
  if msg_id == 33 then msg_name = "ProxyWillStop" end
  if msg_id == 34 then msg_name = "BypassPeerWithLink" end
  if msg_id == 35 then msg_name = "StopProxyingToLocalPeer" end
  if msg_id == 36 then msg_name = "FlushRouter" end
  if msg_id == 64 then msg_name = "RequestMemory" end
  if msg_id == 65 then msg_name = "ProvideMemory" end
  if msg_id == 66 then msg_name = "RelayMessage" end
  if msg_id == 67 then msg_name = "AcceptRelayedMessage" end
  
  return msg_name
end

